Return-Path: <netdev+bounces-224045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F34AB7FFAB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D8B4A80EF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D232FBDFD;
	Wed, 17 Sep 2025 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMKpEVz3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57823717F
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118261; cv=none; b=QkPCK0rW616Q+Xfi4bOc+gTTXlplAvXFF6Qpet+/ks/u4/wyCjq/kFpbAmdrKn4BLPoFFBVDdyOEyvRT/flQnVssajQ4RVDeCqfGLRZSOFbnImGGMcZsQlZ8JEZ5aAc4/6IPw9FpOvng0o3zyZ3VTTXchMb2kwqIwJRKYqx3PkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118261; c=relaxed/simple;
	bh=FI4Tw0mfX75Rn3FhElw/7vvzWi+gzmpBmHpV6afTOro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=To80JrfLOrTwAMvSHpPDOBzwfiysMxSpYVJ99R9Ge/sw9gIt+6raghjHVG2gvqYZfsafsL9vhOJrZ6GyZG+P+7KZiF0Qy2/i+10H/MSDHTCz2HMunCNduu3qFdwpcWJKOf36pcgTtNk+nPEBvQpF9L18EEzEkatcVNRy8sMkwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aMKpEVz3; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea5bafdfea3so1310841276.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758118258; x=1758723058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI4Tw0mfX75Rn3FhElw/7vvzWi+gzmpBmHpV6afTOro=;
        b=aMKpEVz3vMaRodLcApRw1+UWqOctpWlAaPPko0wCgCU1kpHlIjfAOuGFux5HhOHFAR
         CC4axVrQ2r6S42Slt912jT/n1vaGUkoufzropGnvfKlXXJhLTxz1ztzznmHbnTLPx+GA
         8x8Qyr/3dwcu4/f22OVaU1E3f7/4W8Whyr3DENHbzT5TNfHyk7lww7ydNwtO617+EYlx
         nJu0NT0LY+/IfVzlSG0f49bJ3tyD9hG3Mx9l76F3seiFFidEGHCQ4pmqdIFSu/tCLImL
         oHN5xzX+zO7lhRkJ9t7gbZAWuEYIJBCExVW+X3CHezyPFn5BMKq0UQl+LtagZnh1AAiP
         sr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118258; x=1758723058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI4Tw0mfX75Rn3FhElw/7vvzWi+gzmpBmHpV6afTOro=;
        b=uqfUrF4A6kWaEAmFRP7gJjDUr/8audXZ5eC6fLBP+8IrLSOscSfDKFhudJIs98ykkG
         GDauDHT3JQr/KNkSaBmOW1rehoKjQ+okpB4+7E8Y3tPnJ/yjOaz5S6Hvz/3LevClhVf4
         TDUrVQ4kaDXYiyS6i5BvkIy3xX7gjOG8c7si3KUQTDCs5bCpVQZydIW4d9scvNhryUaa
         AzIKUkbWi/wmus461avsugduwa55wetAH+dVz3jkvSnbmQy3RyOt1TQv9A3x2xwxt4FE
         DSvHCD3VRJvAs0cXcTSu9Ak8Kpb+jZsNaXJJCtLUqmzsJctgbYEwnCRvuwfqQLlnGnJZ
         O2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWkNpk+EyYMG0pwgG4RQhuT8uaUxq+kyFaIaJoCzKCW/szXxUjQZ0ho1SAYMYcNK1K5iiavRIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzcArlwIaHmn3CBHFc42m4UVGuipDIK23vBF1H/2Vpo/ZCpNKp
	JaIFUTyCp+rQNgRXxGaSJ8QC9Fu7PpmzU581R/4s85frNnUJumCZEHsriZYldb0MxSUCU+adm2W
	DLLBLAXHa9UyiTKpRzN9vQEIDPv5m3/5X+x8OinN5
X-Gm-Gg: ASbGncuyMq+dUd8oLZTrVDcfgL5eAiKu2SF+LKRvBtmNKQmM5OXFFktr+i7CN9gA9xe
	5OZb9OEBGBl/JgsGYw4SuD4AJ3uR5/2gwWsdox4Eu+A+5qz0Q+XNqsBvnPSY90eyw7kvz6fSyqE
	r6071UmGBDhhmkYYdViAUKU2FD334cx3E9ITxp3mN3/2ut37+5CmisAC39gQnXY+PiFBGStXSlF
	A1IwNpjvzorTSXMEuJA/A2pOOFgukrkQg==
X-Google-Smtp-Source: AGHT+IHrTXnwlpzVPwnkPsAqMNhlJxxq+qRxO+E15LPBkQSBqcwbY1yfCuugi5qYlxO9bpWFbnkXiolbIAVb9f+uNQA=
X-Received: by 2002:a05:6902:6d07:b0:e9c:364b:9292 with SMTP id
 3f1490d57ef6-ea5c057e81dmr1744832276.23.1758118258158; Wed, 17 Sep 2025
 07:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com> <20250916214758.650211-8-kuniyu@google.com>
In-Reply-To: <20250916214758.650211-8-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 07:10:46 -0700
X-Gm-Features: AS18NWBC5cwCdqDBd0Zd5re5LWCpSLaZFXIteAviHW8wyt39ZmpWGFo3WVL4JWU
Message-ID: <CANn89i+ExT8U3bEK=2tKM0TSdo68U-5FbmZzchwiPJVVrjYMkA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 7/7] mptcp: Use __sk_dst_get() and
 dst_dev_rcu() in mptcp_active_enable().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> mptcp_active_enable() is called from subflow_finish_connect(),
> which is icsk->icsk_af_ops->sk_rx_dst_set() and it's not always
> under RCU.
>
> Using sk_dst_get(sk)->dev could trigger UAF.
>
> Let's use __sk_dst_get() and dst_dev_rcu().
>
> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

