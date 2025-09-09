Return-Path: <netdev+bounces-221363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A6B504D2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86747A3BCA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF77352080;
	Tue,  9 Sep 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi/Q5WSM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4122FE02
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441127; cv=none; b=osE/iM/oFPxnDiyPVCzbt97KBAM1T0gz257PsptfrWwjpyb+5EeSMac6fE2DudzJtmJ22RTMfZ0XSaYg4AvX862/YdIOfBccgFta8L7wE8uQqUoTO7HFClqOL+/OqcQ8tYNP6Aq92gSlLgnODBMnCnwjEQ8mNpdzQxhbzVAr07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441127; c=relaxed/simple;
	bh=KQnBKWiKGDvpyRUHkX9MClcceIL7m2tOELzThwhZocI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgbjeIXiEbTBC1uMytQSNNoEXRNXMpsIzowx+PNMyux3abI/vewsu3tRxoMHi0/7WRL/RFtdX4ZDVTpggcbs9v9u0We1yzKiS4+M2comQfinPopOSrOA/2kAkAtYEYOURfnqibiYryLt9cEN5gQxGFgwyuneCtWjRiHVZ9dbh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi/Q5WSM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f62f93fdfso1015e87.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757441124; x=1758045924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JzUzLkWPMiRqdMU2PWQrLrGvNPVrl2fkDBIgw67gME=;
        b=Gi/Q5WSMrC0wCOEp3QRMImuW9buVdiKy1KIsbhQKRIdjt5tu4Ze8/0KL1GcUM9ufNg
         PHivylWrP9aDsM42FKV3PuF29oJo45fG2zbbsWAiV0plKT3M0zo78sf1zFEM/dS8D9CK
         R6t+qohtbetx9LLIJ1JFlI7hm0ykgKyp2dArMknK8Xm7LMdA7ykpp4cuSLFJ3VIlZgOq
         nIQ9xxy/bzwub4SBfbB3kx5rIvtefef5Nhrz9r74MkQe+qfolrkiGxoOze60pRbI+Q8W
         37/X2SS6Dug3WSKpkCtqhh9yQVZnGjMkrX1LNauNcdN62RAzycgppRYD6YIqJlEUySTt
         +5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757441124; x=1758045924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JzUzLkWPMiRqdMU2PWQrLrGvNPVrl2fkDBIgw67gME=;
        b=puXmPnNuV3B/G6Db657mmeMAtgoAciVTss35MyaSpawUMkrEzw7jVeU14aBCvT+t8I
         BH2uTIDLWmmZoTiCO6/oVzkyDoDnho/y8Nx9LpGypsbPzlcRUAiejCXVdXgRDDLxH80Y
         f5ib4KzAQieFFWAWWU/mCTjbXHSaK0ucrv+l9fREc2nP4p8nl+eycOU8lFS5v1oCqszJ
         16QglBQjMk0Mz/0b3VhcMZxBkHKymmDumeiOcpJSR5sDFI/zlMTkX0jpI1ih0jOmtVsO
         kukRD5Zgc+eKSr4DcVQsyqHbr8d8TNSOH2lrvpJiTpdOHa3AlwkDhdXPs6PeLHCe2Kau
         sjRw==
X-Forwarded-Encrypted: i=1; AJvYcCV0F2q69Y7siJJDZPseo6z2iBdk5umzvhUQMg+nn+YUi7nqXo3c9Qp/XrhCrldwP1Xg+e8a+Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYVH29djZtUMfjjF5AJKJ1N6umkETs1oOrT3GMciB1hiB7Fuz
	STi2FWkHVcxsh5WzWEaZupD7nAssq3NFwYMlaczUDhyyd5plcA2vmQHw+1Q11LTCdzN72UOwK8z
	ypWRAgAQ3ZdRWSQWJGc3t2jTXGt2eLypy6JnO8XKEFzRorEYrp+98yWgE
X-Gm-Gg: ASbGncuRferKde67h6xlSWGK6jz3dNdqpOgae3KrDQl6IYvBzcGthu0Fp114+mGF2Nl
	2gpAtK8FbVCen9nqZpMAlJ5o71wLCgT0UBAKyR4vBNZJbru74QuFRZqQsjLBwhGMi5VkPeso3oH
	ASGA+gYqDA8A/igChWxFuvT/ev0HOHct4VE5KwAMJfyKGr8CxSM9NiTFm25eMpaP02HrkWmVaxH
	ddes5qOjDu7WMBLph5dxdJvew==
X-Google-Smtp-Source: AGHT+IEq0HRTqN70vCk22jYNZP5mnjKPrWVQCw7vun9YsLjMMwNy0CqRt92AN65UbMbFM9LD4XcQLKRKwceU6IW3cTI=
X-Received: by 2002:a05:6512:428a:b0:560:8398:e9a5 with SMTP id
 2adb3069b0e04-56aed65b73dmr20459e87.2.1757441123492; Tue, 09 Sep 2025
 11:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908175045.3422388-1-sdf@fomichev.me> <7726e657-585c-42d3-aff2-c991eed42361@kernel.org>
In-Reply-To: <7726e657-585c-42d3-aff2-c991eed42361@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 9 Sep 2025 11:05:11 -0700
X-Gm-Features: Ac12FXwbOdbzcbK_hUaTNFAZfeytFY_q3maZDk1PEYKLZ5mfBs3ETGGpJ5DRyzw
Message-ID: <CAHS8izOSONfHk2pOYpoRxHNGvp3i6Lg3+FBsjZuRz6NAOOkrxw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: expose tcp_recvmsg_locked errors
To: David Ahern <dsahern@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com, 
	kuniyu@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:44=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 9/8/25 11:50 AM, Stanislav Fomichev wrote:
> > tcp_recvmsg_dmabuf can export the following errors:
> > - EFAULT when linear copy fails
> > - ETOOSMALL when cmsg put fails
> > - ENODEV if one of the frags is readable
> > - ENOMEM on xarray failures
> >
> > But they are all ignored and replaced by EFAULT in the caller
> > (tcp_recvmsg_locked). Expose real error to the userspace to
> > add more transparency on what specifically fails.
> >
> > In non-devmem case (skb_copy_datagram_msg) doing `if (!copied)
> > copied=3D-EFAULT` is ok because skb_copy_datagram_msg can return only E=
FAULT.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  net/ipv4/tcp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
>
> Reviewed-by: David Ahern <dsahern@kernel.org>
>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

