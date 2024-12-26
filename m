Return-Path: <netdev+bounces-154285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1859FC9FB
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 10:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8C8188196C
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2B61C5481;
	Thu, 26 Dec 2024 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHKQ9Gnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212AA1537A8
	for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735205900; cv=none; b=Ta2+lpa+CEJfjV+QuynOga8WctlHZL8K0kO9KwX7c7vhZrsUCNPrP+Dp+ceeeVt72A2Oyfak7P9zcK/CP0+Tto/kwpJUIdoNeGMboE84WakDbIhiMxOzqifP+q03Zm8y6r/4EXi4r2SJ3QeIGJw7VXEhRaKYp6WCqJ9tfyo8sto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735205900; c=relaxed/simple;
	bh=jDI9pwAV4z/np5soxy42nY+quZ/zsQ+ZPeBjrUKITu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oChjjnAHvlNVW5Be2MlHRMghZ6MxbnuJy7YbfMWcY700rnhSDsEP6+iOhOEzKOWVhYfJ41T4TfgwLBRMfLJ7WE7oh6bnIH7/Q2nX1Sll9nNaphVUbbK4FgBt4XJ18TztczbOm1zAgrNZgmHo/PHm7uRrcJf+k2bp4nncuayIVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHKQ9Gnb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso12222865a12.2
        for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 01:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735205897; x=1735810697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDI9pwAV4z/np5soxy42nY+quZ/zsQ+ZPeBjrUKITu4=;
        b=JHKQ9GnbJwRqs9ojO0i8cUvtvJJb9X0PtyaaUo4olmGqASbQWgOQ081CxJJq+Rf1JM
         zSR+1Rnv52zefalxrpNtfAEizQFrbVbu5nWuFXLUClrQCifCExiO41c2OiTtfx0d43CO
         kTqBJtboucAnJehYq+oaz+FN6vL6yoJRO/DtZM3n83pCLYnBv4bOIG6e59996mjsGhRL
         qTEYzjlIAau6gmWNWxJQH4yiwzI/vXlDJOxgIwHO8nUNgQV256WpkxXsDTRqkcYAxb/m
         d9Gw0jEI6z2Sr9cDWsYMM7g14X6S5uUdtl8X7GakEYq6gItWr1/yQF5ZN5uWaXn9jrjS
         j7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735205897; x=1735810697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDI9pwAV4z/np5soxy42nY+quZ/zsQ+ZPeBjrUKITu4=;
        b=qRA4XuehaS7pbl7XrDx2QKnJMb8S3jmlm+f+zDGMrtxgTcYRPcVOtcq1L34He9SdcD
         JrcFNV13Er2G5rcwQNkqRQfyw0wLdl/1dJu25PfVs8Mi2rYkxQyu0mjFMMZFPbB6Ne6a
         EN9ydVoMWDAKn/5lKbJU1v8ureHwwB+yNgSEKGkYBr4OGCDJGf+RwVI1zNocKEa2itcR
         /VV0ns1I0bZb2XAQTZotBQEd+9RRBlx2nvJHYvOxCK/dUKPCoGY727OcSYk9yK6qmaVI
         nN7iuyRpI+WD6yhZNyme33cmmz+/8lOc9VQr/+m2b4Oy/XuANFlgUPEP6QlNfjUjYgcW
         qvGg==
X-Gm-Message-State: AOJu0YyIppb5VLQdw5kQrx2LDZvJlLWA1YiXk8/4EPCYAlt+j52Y2ok4
	YYEDsSHjAdJlnIdTUJfN/mkgkKYf4mFxy/ffGZ0P2x8dSV5fjWqpj373F3kKaH6oIzhkJ0K+jc/
	8MsOLLHH643ompNUjfNgr5trT4id9vFPuukwf
X-Gm-Gg: ASbGncu9NVIKwQJy0cHhHAU3sXw3dfG66usJcNBf/BZYrRZHcLhM0+DMyO28vXMHZo9
	zVboGWJ2c9uGneUOAVTFkDCbGmGE0/vx67FWbtGQ=
X-Google-Smtp-Source: AGHT+IFRgZkmYLrJe8wxVmGkO2Xypou65whuE4uLVxF1Pb5obhOAGJJLYco8iLHowjyGB5NZ+aLKxh+HuZqqbAyUsuw=
X-Received: by 2002:a05:6402:430c:b0:5d2:fa65:c5e2 with SMTP id
 4fb4d7f45d1cf-5d81de1fd2amr21487025a12.22.1735205897246; Thu, 26 Dec 2024
 01:38:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+9Lt78ErDdbgVuOgvSy=UBz2Vhnp=cJYGvwuuQLp6qjg@mail.gmail.com>
 <20241225010723.2830290-1-antonio.pastor@gmail.com>
In-Reply-To: <20241225010723.2830290-1-antonio.pastor@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Dec 2024 10:38:06 +0100
Message-ID: <CANn89iLQq9Uf+HJAAi30UO01SPR0q2jr6FKxmewz9v=8XjAwXA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: llc: reset skb->transport_header
To: Antonio Pastor <antonio.pastor@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 25, 2024 at 2:08=E2=80=AFAM Antonio Pastor <antonio.pastor@gmai=
l.com> wrote:
>
> 802.2+LLC+SNAP frames received by napi_complete_done with GRO and DSA
> have skb->transport_header set two bytes short, or pointing 2 bytes
> before network_header & skb->data. As snap_rcv expects transport_header
> to point to SNAP header (OID:PID) after LLC processing advances offset
> over LLC header (llc_rcv & llc_fixup_skb), code doesn't find a match
> and packet is dropped.
>
> Between napi_complete_done and snap_rcv, transport_header is not used
> until __netif_receive_skb_core, where originally it was being reset.
> Commit fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
> only does so if not set, on the assumption the value was set correctly
> by GRO (and also on assumption that "network stacks usually reset the
> transport header anyway"). Afterwards it is moved forward by
> llc_fixup_skb.
>
> Locally generated traffic shows up at __netif_receive_skb_core with no
> transport_header set and is processed without issue. On a setup with
> GRO but no DSA, transport_header and network_header are both set to
> point to skb->data which is also correct.
>
> As issue is LLC specific, to avoid impacting non-LLC traffic, and to
> follow up on original assumption made on previous code change,
> llc_fixup_skb to reset the offset after skb pull. llc_fixup_skb
> assumes the LLC header is at skb->data, and by definition SNAP header
> immediately follows.
>
> Fixes: fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
> Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

