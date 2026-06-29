Return-Path: <netdev+bounces-302438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wA8+KO3MQWphugkAu9opvQ
	(envelope-from <netdev+bounces-302438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 03:39:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E41D6D56B5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 03:39:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=guS9qKyK;
	dkim=pass header.d=redhat.com header.s=google header.b=gb5HvBnX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302438-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302438-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EBF830041D4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 01:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B47379C45;
	Mon, 29 Jun 2026 01:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987ED3749F6
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 01:39:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782697191; cv=pass; b=otSWaOemhq+mU1zMX2h6v0+ONInTxibEbHzhaNfZO9p6fSniuiTIlpsYdo7LJkg7tpGjiJ/n/XPO87CMU0g7qq62w+XH8b2NUHCXNeBraTZ2i95RZfGwwZZAK8hOvenA7JpGZl4ILALJmQ07EDYQjQU2p7YivnN6ZO1hV22Pnlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782697191; c=relaxed/simple;
	bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUONkojYNDtH7Mu8CDdUUSIMBN9QNwRrGgEF/9b1Li/KjILSQa9nIBy3EuIkdSyslBQopDl4J5WtiMmnWG5dp63V/1dmiqjGN4+1HJLxLfsckEmMGvX7Wt14ctayEk+4dZiE2C0sMBeEMSIDHoHD147AMZjIFlaMHC3jjibtY3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guS9qKyK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gb5HvBnX; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782697189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
	b=guS9qKyKHCLfnROCdmiJut6dro2qAm2B3AZOul6Y4u+97/IUaNMe27THtK/ajJ+P5BPUpD
	CHpEI++2ukqhd6dxbg2NNyBXhs+rzS1bC0gzU6tQx0lyOiy+pp5r5chf71UDaJln3CKK1p
	OaN4l1AL6ziS0yI9Xh2bI2pNFs2LWg4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-O0uEqBMuPxCOiJygcomyOQ-1; Sun, 28 Jun 2026 21:39:48 -0400
X-MC-Unique: O0uEqBMuPxCOiJygcomyOQ-1
X-Mimecast-MFC-AGG-ID: O0uEqBMuPxCOiJygcomyOQ_1782697187
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso1437698a12.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 18:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782697187; cv=none;
        d=google.com; s=arc-20260327;
        b=C81Tk2eH4YfITJswun4aWlbiu5UCk8YbYCrPoNh9a4Jvp4sGomYL47MSrrvde7OKUo
         Fuv7ISFRUwboB4BSfgNiDS8bUxgKw5qRsqBaoIn1hsKF7QvRmxzwcfarW4WwD6yS0K0F
         ExIV1y1cGJhI6l+dLHFbydvUvvOK46fqWCGZfPG1cmrDuTR09Tbhs32HLILoaKCBKGQ3
         cYdk3946m48dhLZFRRzflQd03ChReBbiwGMJlzOdmzu27nPaj9AB30cyoaMsa0dGm9oD
         KUV92BlnRPJLUjBTHK0KY38pYi804b0YgGf3hhR/CusnTTsf3cTw9jCd7xyj8k5uaish
         W4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
        fh=zcSx0lr+qcpXrfs/+x9ff6Ixh0muL2uUc79cc8fTQeY=;
        b=o2qWOPiV380557/c1dGjhWswlyknqDPgM48W1jHAGoJH/Cf3qd92ebnIRwOSbQ1OFh
         Qn8+b0XfNNz+l0kCkky1SLQPXv0IoIP0cat5+Gk2v9W3rSpan2marQb1e1T+OIQvFZZT
         XnxnaW10d+wfogDsm7wWI6G2rppnySn9eyUQ6r+5pRGoP5m51yJmJdyelxhJ2fJLDU7L
         LXR4njTb2EVqX95ivxHH1a6Jasl3qtszvqG9PCUKbItDxWb0+nEYlH2OHHA60HBN68GY
         8wEgiZPlNtlz2s5Wtodwl1ZI4XrJOyvyOUsLV4JFbK/Cc5x9qZ+K8VH8lkr0ev7FT7ic
         +Ehg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782697187; x=1783301987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
        b=gb5HvBnXoNXOyTSnIAkV2b4c139EJEcEVPMaA03/8XlZMlrj7z1yvqT/zdWpHYcAbM
         uaPX/8f53LC3oeogPs457egcIioyT3AluBjNHUGSnnCMa4Ebo+7qqXYpGtXDQZLd1+B+
         ouq/40xHQlxWFfWwmFoN4FskH4mG0sUtj+B4ffl+cn1Pyu/U/3wfg4BqigNGSsCfYxlC
         gcwaZmLcPzbavNbnMEQYpjEeSlGknp+05Ejk7BwOOOFvaN6FM5ZDGH/aSKrBvQX7WKBG
         rwrOL+8e8EJReWHdvkjnd/Rby6rMtyWYkb3mIvfxBzx7PcwKno0VlaZi+zEA1+Jmvb3X
         3Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782697187; x=1783301987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kkOpxqFIZg5d1jfHXy9HU1BiSKiCiIXchziwHTu0m/s=;
        b=k5gMMcLnKCdZOfWSUDu8bFMPwHLrLeMKUoNGv59++VHt7O5wIbk499WReGIXXZm/Al
         t4KuNITFQBtK3CWpd/aGLOKGJvO3GJChmnAhZmclJ9TJ7u8FW5xP8FQS/O4nHKvTqaqT
         /skXlfWSjloEGGaYTyJGn+Uk9gDoXIA9ggyp/3NKTs51uoOEdnky/KE+DC1e05ttwwLS
         ryGbqJ9NMbODy3xlOx3ZhgfTbvCek5NzGaaKTnaBv8KoE/HzKVL4yvz44yOVl847bVjR
         S2CYlmRnINMkCRdJ2JLJIrd0gNXD14dvOKlJT7caLWOpsH2Ecc3fpcaofPzraa5ODf7l
         1t0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8JEJKi3G+ZCRQXK0WLThMaElbjbD6HUQg9uxJ+aUIAyybrcHAsweNeiZGNaNHlxxuZxjHwlic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzRyGhTh/QWqYokd/dVlnDBy4eYiW55bKEZllXM8xSNkCrfn7
	zA/UpaVqtOoGBz+LuFIYsdVntulzH9nxBkjb9WUOSi56HzITx70PBhbrGQS4ic+yDZmc5mkFNm+
	c2KzD1BPhb8iVHW87FUWq8ERP6cKG3rA0zc01O90UEQmXJKXyVbfmgWS/9wbPftCaTMpfDWhlYQ
	Pa+w+fDLd5qdvk+PQZgZlWFJFJYK3tLE+e
X-Gm-Gg: AfdE7clAKumFmDSE1xSRcbpIm79qRC+mmtx1DnHbGDSJfT8MP/QjMc/ziqAQeaYSdpT
	tmIPPyutxSv2RMxpPUOlvrr9vbTftGiddAhfB31x1xjCdGcj6tYpQZkIeRxm13zio5d3o5+hkfK
	hTBGALBV/bTqvF9pkh6HEgSpNpYuDLPShkYFid4zm3YPOBk9yZ2ja1fDj57csG8Bw6h1E2mQ==
X-Received: by 2002:a05:6a20:a106:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3bf735d848amr6431517637.27.1782697186982;
        Sun, 28 Jun 2026 18:39:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:a106:b0:3bf:735d:7fb8 with SMTP id
 adf61e73a8af0-3bf735d848amr6431502637.27.1782697186452; Sun, 28 Jun 2026
 18:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626022039.96139-1-jasowang@redhat.com> <20260626180433.3e302324@kernel.org>
In-Reply-To: <20260626180433.3e302324@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jun 2026 09:39:33 +0800
X-Gm-Features: AVVi8CfiIaaNu4XD5f16KUtQbZkJ7QsuoHzBIziOF2mgWVcE5Rb-guxFM4B6N3U
Message-ID: <CACGkMEveL7Kp8PJfbOX06LhboaFZt_1tqu7z2rvCnO6yj9kSkw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Jason Wang's email address
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	eperezma@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302438-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:mst@redhat.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:eperezma@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E41D6D56B5

On Sat, Jun 27, 2026 at 9:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 26 Jun 2026 10:20:38 +0800 Jason Wang wrote:
> > I will use jasowangio@gmail.com for future review and discussion
>
> Do you want to add a mailmap entry, too?

Exactly.

> Otherwise I think you'll get CCed twice (once for MAINTAINERS and once
> because you given tags to previous changes)
>

Yes, V2 will be sent soon.

Thanks


