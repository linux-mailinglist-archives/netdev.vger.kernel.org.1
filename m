Return-Path: <netdev+bounces-284547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCwYEYw3+mnHKwMAu9opvQ
	(envelope-from <netdev+bounces-284547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:31:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E39874D2B5B
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E245F3100E4D
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B745F4ADD89;
	Tue,  5 May 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TWlmJD/f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F625492195
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005646; cv=none; b=EDOvi6/EHTishsK7tGhnV9QDNDAVWg/tw9wVZEh/FQGah8aDfTe+gUgP1N1OnLec3b2N1Rq75PACLoevG4Suyc/yyr7jJkIWn9SDkcEs1hee8BS+C1GslMCz3JNQ6lY7NpwGntPXWuTQqUkTZhO0PYr1+qL5flkZFZ5cf2g27Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005646; c=relaxed/simple;
	bh=h2AlK+8MmYvPuW3IDG1cxyc7bUV8nvXUFzn2jnDpp6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qz9sBMkMiFK5nBzdctSZVhrxgsxUEvZb7lLCp0pypBwKtinC/7cSAYVBS+T1zNM3GFsWgOYgJwGXe0hTrgsPgXLapulqo7c3LEjKZY67eu5LlKt/XIpiBz0Zjknd17Q0OLq8sqteUDGmCdTcc0+it5uJPd1esIB+aA85G5mSGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TWlmJD/f; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c8006f8ab97so110950a12.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005644; x=1778610444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGNm7c854bmsEYSmmRpo3hBYxzAKRiuBt/6viyvE9RM=;
        b=oZdQ5RnSBRdIbkkN3//ozlJwMCDfxpJKdNE5GwE5G6Bp17C3qUqtN8RFqnuEsPh6gp
         2vPP+7KjerJR7vJxjsos5LQk2sH1lElBstZPC5ITNav4wKBN/ou9kI3gWds0cDgNnVcC
         +su4ab0AMRvO2A43bCVqYeCaEVlS8/seXl6NyKlByHsYvguMXizvizB+L6SafPJopujr
         0PVQYVB0yNhFjxpAlhibGJ/yaIaqeruL6OjpBb1pbnh9u9loQkjFdR0Qe9LrhA/2oBfG
         xCsl+9mjt0BrjQpBOsCZjehhpcIBlsjrlytW6lmnBh4/OVwfIsBO7QCpsW0gpwZPXScP
         wTFA==
X-Forwarded-Encrypted: i=1; AFNElJ+oQej5hA9GIobYeT2e0tQDtDDwcQOYMOtK8shEIIzsAR7pKb1NsHOCVvZ5nX6GkPJG80f7hJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2nGFYcIZaGNdfa38WpJk9mDByzSSqzbRXfz7t3m9mm/td9gC
	5PPalgR4DiuqNKrwTwt+/vIzuvb2i34BG8i6IamN+UtR2FxNPYYj6rtRVLg0YwTovsAguXICEkw
	HMeJaGb0yO52yUU74JqbOcOSJjOHLq9YTwtLQrlAST8+XJg4h9i4SgMRg1MMx17OckEJmrtDQ4G
	pX5e8cqBwIGrSmd5wfyJ719uAisXpwEjYseLrTSlz40gULtlnm3FXCr7C4c9T/FIc9GO2hp1eS8
	LKXngaWYKCkRfs=
X-Gm-Gg: AeBDieuyRbr94yfncqW4OLuJx1hQADLuP6Ype6QhTAv7phxqS4f5S3RKtO5J8RTugpu
	5Gwt6NUh6H5tJv2mOzKjuB3gX+RmeZwppmK2RFj2o9vvXo9fEP1EPKrG577vo7WuM/i0xwXUdN+
	h1cTiYpYl4yIIPRYwtZGsldzcsxUe33r3DUOrKbEnys95LVAV1HWdGqNlVymHlf1GiOlGNx2cdQ
	qmbW2frPR5usE0eqq2m9T/VNhOWaTaRUVaDLPm8dwlIISJF2IxGMZrffOJ60Qmq6/qMp8CMKQDP
	k9HXtIdeKkHBJrikBDKWEA1yvlCkJALVsdsxinECl1BnkTLCDHiK1OaLS4OhOcoQsPQtKZ7RHaq
	mgn5ranY9qCUyh26Ou61uSZG/Ls/AdEWhUiw50+5bhMvlOqLfPwUmlYznNgX4IldIeAzK3SNR6C
	XyT+wF/1bcmxquK0+FrSh4GWl9MqOUNGnEZzs6dyIhGkf3vcKL+3jf8LhooM+7VjUiP5nv
X-Received: by 2002:a17:902:f78a:b0:2b9:5926:d057 with SMTP id d9443c01a7336-2ba78510042mr947065ad.0.1778005644313;
        Tue, 05 May 2026 11:27:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b9ca9f517csm8552105ad.23.2026.05.05.11.27.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 11:27:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8954b9b5da7so7973626d6.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778005642; x=1778610442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGNm7c854bmsEYSmmRpo3hBYxzAKRiuBt/6viyvE9RM=;
        b=TWlmJD/fcJT1MZPj75aqWVeWnzjzrf6PsNjZmvGHMuhHCGMgQ0Ul72gJK4GuNMb9DX
         MiHzWxZIhfZ+UHr/XNXZ7eHEz9WcT0Wk2H9YTlNUi5AWfJ1HgYHQTUgI8IB4A/3Gz/gM
         +VFic31X8XOafKkvaXvkgq41i04VvcC3gWWMo=
X-Forwarded-Encrypted: i=1; AFNElJ9bc4jv9pkG/LFhag744f9guemgKqH6qj+mhAgR7vgahHUnhTxdLa6n4FntoywqcMOt8cfcpQA=@vger.kernel.org
X-Received: by 2002:ad4:5d4d:0:b0:8ac:afca:a68f with SMTP id 6a1803df08f44-8baf24a16a3mr45786806d6.1.1778005642413;
        Tue, 05 May 2026 11:27:22 -0700 (PDT)
X-Received: by 2002:ad4:5d4d:0:b0:8ac:afca:a68f with SMTP id 6a1803df08f44-8baf24a16a3mr45786396d6.1.1778005641958;
        Tue, 05 May 2026 11:27:21 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b688csm170263516d6.33.2026.05.05.11.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:27:21 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: edumazet@google.com
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: Re: [PATCH net v2 2/2] selftests/net: add packetdrill test for locked SO_RCVBUF SWS
Date: Tue,  5 May 2026 18:23:29 +0000
Message-ID: <20260505182329.15353-1-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANn89iK_SrGx4UuN-_h8LY0DFBwf8+hStba7vdjFnEogvo=N7A@mail.gmail.com>
References: <CANn89iK_SrGx4UuN-_h8LY0DFBwf8+hStba7vdjFnEogvo=N7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: E39874D2B5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284547-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Thanks for the review.

> I do not see the SWS effect you want to avoid in the first place.
> 
> This test is an ad-hoc test about your change, but I still do not see
> why recomputing tp->ratio every time the rcvmss is increased is an
> issue on loopback interface.

For the packetdrill script, it is taking more time. To actually show
the window dropping to 0, I have to write a long script with many
packets and application reads. This is because TCP does not shrink the
right edge of an already open window.

Since the C-code fix in Patch 1 is tested and working fine, should I
send v3 with just the code fix first? I can work on the packetdrill
script and send it later in a separate patch. Or should I wait and
send both together?

Kindly suggest how I should proceed.

Thanks,
Ankit

