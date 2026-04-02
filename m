Return-Path: <netdev+bounces-274394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI0tKIoSzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:54:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F084D384C43
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01B63302D957
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3F37CD55;
	Thu,  2 Apr 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFhrO2Sp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBD19K63"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D3382F0F
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112020; cv=none; b=Y3ZNruFfyOWTWtfNGypSXfZyijzyYbY+n093O2o0qidu/BV/4gf1DUupZnIZFFcyCTonhATHqT80hfVhoNsQqroZuhXkE0j+wXVr48QkcjFvA/IDLmn/I9rxOC5l6Dk0dFN2zVhJ1f7uSYJadbWPrgGUvUY07pAxuCd84mAXdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112020; c=relaxed/simple;
	bh=2I87bnDZX2WzKAbaRibohvDaPKjHqvBvb7tTxULU6N0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SLhS15fW+97rECOPo3TNFytFqYGPc8QywTe41AhgCYYJUJltTpvJ5JYQfHjNxkJGdtYS4rFHlAgZq4Uaw/2abVBw35SLEumJNZ/nfjvrqPKVPFzIOq7Ce7HOdzY5zuCqv/WM2oSkx8U9ljx2LBgAqpA70TyfUlO0rOlSY/rVUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFhrO2Sp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBD19K63; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775112017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CfapFxiryQkOPSjUAaS3fAx//bfuZhAx0UUk6lZLqAw=;
	b=SFhrO2SpdlqwrWbX+LB7H12vxPtK9QxQc0crwGZhVqio8IXkx0gybQMJ2mc6zYDOKUZIcI
	s6bwzZAWQdBQ/Qk2tnNil/3v397vAAN/PTv9IK4PpSbnxah0MObj4yqvP6M94qeOBxhi9S
	l/Po0VlfJlXvgxXYpuk5fe+8i+lIK64=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-NcnaUY6hMY-U9S7ywCDNUQ-1; Thu, 02 Apr 2026 02:40:16 -0400
X-MC-Unique: NcnaUY6hMY-U9S7ywCDNUQ-1
X-Mimecast-MFC-AGG-ID: NcnaUY6hMY-U9S7ywCDNUQ_1775112015
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b8f9374dfso1128960f8f.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 23:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775112015; x=1775716815; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfapFxiryQkOPSjUAaS3fAx//bfuZhAx0UUk6lZLqAw=;
        b=UBD19K63NHTdHBLkf/LRb9TTWWAGdWmyhdV51SaKOoydz6vFujZIaYUXkCxDRaR5v5
         TahHUq4rnStzbjbEcLfl6+m4fsn0Ssx97a1hLnGBBoqgJpUJpEMgRdGPYo/1uJL8Eymt
         34fEQT0bDyL7hT//HEE5jVKxG8XhGka25zN1op+Mu6JYVpEdq4J0UR2gKWPnAUccMlD8
         Bg04JPSrw6MUqxK8FILj4A28XUmtJPm8bf2pGv13fzA1n7aMe1bFWyxix3WN87llURm6
         fpwaOl5dTBIX9pTiiHZmQD9DhPolhT0+4zVjc22wvJZ1hP8tmkCTPDWD2+JYfEwmxF6F
         iyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775112015; x=1775716815;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfapFxiryQkOPSjUAaS3fAx//bfuZhAx0UUk6lZLqAw=;
        b=AHQ/51qjB3Styt4symvsXRTewePOLTUz2umYPqownQFnIj5OUxvCO4F5mhw5aaN/1n
         TlMt+dc/ki3CTO8aCrQ2NbsLRPKclOzI4yTURuRh4mKr9oB+JlSY1hCUDKelKkqU4y//
         pvjd9ssoWHr1xCoL/VjtrkbfE4yX8Gy41RNjLyMpwYvzT/EVt9vaG6HVE7HpUQmVxYXa
         4xE3aAq/qUmM0CGXtq9SETwa0ORyVCi40ufV71+STEbYnEh7MfwQH0XSlvNLJeNxxGUy
         55XJuVRWxL/53vKmLKLBlo06KAsEYedDhs0P0KYm1m+Z+5sZo2pB+DQkyK4+yVQhQU1K
         AA6w==
X-Gm-Message-State: AOJu0Yz1YelfWFfSINm7OQRp6gwpOb6x8Z+LjqRuivjM+J3ylahttqlk
	iH+9zyC9Bxc552vE/+lnm+JJDwMaIY32GB57wSRD/hh/ZZCPinmjM8wo42BbwusXWIHeiTUPZoG
	NQSiekVxCs3bp3mVW+HXvS3TDJ17nCEraERYBPXCtVMFI2knFk32r4SqJMGlnGLyut08gMjBL15
	t6NUtUdLo7eY8eZFLY4CJ+2DkObBWW6NgoMvPCPoc=
X-Gm-Gg: ATEYQzzkr7mmQm4ZQWoSdu7ObhxQRG1Fyif7PsSNJjhBBizIfk8wrJsl3CyPNOwPgZt
	3rqrge3QZTwGC31VjQxPBYbTABxPGEbU+kEDEkGhkDicQZDCh+ujj1pIFBktmMtlIOh2faCfmtK
	P0g1vOE/VMGv57PGSslzlLSTz+X7YgGyEz1J0rG6qMtNf1J/N3HOOhwzDXgTEt9y3gsdHu/nXDU
	Z1OGr+/MS5yGAK0k2YTQvKbz1XBDSejFkZHU7HH+8mrN/GUfiljGDCpwiSi33AqzhLn86rCisaE
	+aAjajC9ft4iYlo2r/ZsM6HhAnnzjO9ptbHAoP1f38+N+TGU5K+Xc140maWrgphQrrqlcrvoT1N
	45lqD0CZNbjJ+U4vqFaUNU/zvr93vK02KDAt9HqGaHOeTjNxcvQm4rGpP/g==
X-Received: by 2002:a5d:6ad2:0:b0:43b:4703:9dd5 with SMTP id ffacd0b85a97d-43d211c9e05mr1473229f8f.18.1775112014664;
        Wed, 01 Apr 2026 23:40:14 -0700 (PDT)
X-Received: by 2002:a5d:6ad2:0:b0:43b:4703:9dd5 with SMTP id ffacd0b85a97d-43d211c9e05mr1473205f8f.18.1775112014211;
        Wed, 01 Apr 2026 23:40:14 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c50a7sm5605552f8f.15.2026.04.01.23.40.13
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 23:40:13 -0700 (PDT)
Message-ID: <6600b656-58c1-44aa-a839-b0e87b6eec18@redhat.com>
Date: Thu, 2 Apr 2026 08:40:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Subject: [ANN] LPC 2026: Networking track CFP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274394-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.847];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F084D384C43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We are pleased to announce the Call for Proposals (CFP) for the
Networking track at the 2026 edition of the Linux Plumbers Conference
(LPC) which is taking place in Prague, Czechia, on October 5th - 7th, 2026.

LPC Networking track is an in-person (and virtual) manifestation of the
netdev mailing list, bringing together developers, users and vendors to
discuss topics related to Linux networking.
Relevant topics span from proposals for kernel changes, through user
space tooling, to presenting interesting use cases, new protocols or
new, interesting problems waiting for a solution.

The goal is to allow gathering early feedback on proposals, reach
consensus on long running mailing list discussions and raise awareness
of interesting work or use cases. We are seeking proposals of 30 min in
length (including Q&A discussion). Presenting in person is preferred,
however, exceptions could be given for remotely presenting if attending
in person is challenging.

Please submit your proposals through the official LPC website at:

 	https://lpc.events/event/20/abstracts/

Like last years, we have separate tracks for BPF and networking, please
submit to the track which feels suitable, the committee will transfer
submissions between tracks as it deems necessary.

 - netdev maintainers


