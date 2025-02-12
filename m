Return-Path: <netdev+bounces-165498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53B2A325E3
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482833A81F7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C52063EF;
	Wed, 12 Feb 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmdbK4Ho"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD672046A3
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363599; cv=none; b=QtkM/uVEOp3p9RxbWch40IxSf74A2fpQzNSsvL8aLY0vMXKByAPsxjRiscUxV6wdu2G60xPRmToDMTlA8nVS/Dp2ivUH5WVvE9NWkWl+Z/anKSM6B8sW0dRZvx6g6Qvx1hKKLxnahR4bUmWcGOdoPl8nBh1blILvGs2MAHUnvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363599; c=relaxed/simple;
	bh=bq+kZT4EFuu0WSaKGAKZWKMskYC7otNqha7evbk2r9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V300z7bJgfW/zbOMkWFmTu7qM4daJtBFW6c0PBvHsr4mPiwNhPx4zMy7XtDhglMpOdlOsfcBFtQhvJSjJNkTsXeNJ5bck1F+s8IwQjgZDbxjjHFZm2RpjjyTaqajKyuXwIUtLsxTRitdquFqNgbHIjEZJeo1vJkNGf4BdBPN2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmdbK4Ho; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739363594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bq+kZT4EFuu0WSaKGAKZWKMskYC7otNqha7evbk2r9I=;
	b=dmdbK4Ho6RfQZFPc3w2PpSAmcn7nA5p6IQrd/tpkxroa5zwHQ9HFeaGAZ9TmfM9FEVGTcR
	1wJKYAm3yANr1462qPcClFmWrsJyjtEZWH05HzlR33DIchO99mP0abCl7CHdq91336x/fa
	cu4b03/uifTupFSNz//D2nM99HSSARc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-bcUlar48MDKdWudPcvNHYg-1; Wed, 12 Feb 2025 07:33:13 -0500
X-MC-Unique: bcUlar48MDKdWudPcvNHYg-1
X-Mimecast-MFC-AGG-ID: bcUlar48MDKdWudPcvNHYg_1739363592
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab79bef1abcso73913466b.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 04:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739363592; x=1739968392;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bq+kZT4EFuu0WSaKGAKZWKMskYC7otNqha7evbk2r9I=;
        b=iHIwnqGMRsBTvK9FbdJESMWr7ajUqJbbAilyyThG5oHGcQiuHERDp0BMGqrBPeBD86
         Kn0OKYdl+MyBk1IWaLomC9REsyrBoOrGyBVAZWdzBF3xasCuoDxB1JhaSvxd3MHy/O6g
         wbL9f0IUIq6A1XvtrGrdpEQP9tsAnoWJTRTesyaClioL7X8ntQg+Gn2cwOGWqFWtLGOM
         eitZrFMvqACaVd6fT/L5XY8peY3IRJmzByxff2lnCJO6PkkpTD3IM8s8Vbwp8dTrO7yn
         /Ab7BN2w+2qVYpX5hJeXpQzNtW6EinHlI54mdk3FUiyFLFlOb0qnyJQM7mCW8BUO8wvF
         XP5A==
X-Forwarded-Encrypted: i=1; AJvYcCVsIEqsd+IsYkmQyv2VdJUatONY1i5zXVCjJcszXXufqE/xcQN3nsQm9ob/lZvplQOOELsq2fA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+VryDbFDWqaXrs1WvcRK+y8//4IGXoZyjFe840EVP9FS5IKT
	LpcgxWFbCjFRuulyRfmn0Owh7/gvJ3fgwpiEoxsXJLtd5pI7tnMeQeMSa4OyQjMc8G4LCEhDco9
	DkqNkE17i7WeAR6X9i18R8pPCl1ZFnRSC6e8ISlgCuO5aKZivFJrOxQ==
X-Gm-Gg: ASbGncshYxYhpBcEVgMiQebwR5W5FobKIHpyhlddXG6dMWg+PXy4KWwzZmmG/LGBlv/
	ZB9vo5oOTCUgqMs9WTUPdjS2iH1B6C0OfD1axfiM9nEG+EWCpw5CQWOZ9X75KTnqD3JgyAKuBf9
	l/vPG9wsGV1yrFoZO9c8kirRbaMsNJWqS+tLl9FIeKYCpUkZzdJtrhHksNGltPjZMaK4BjlZxvI
	ejoFP/O27vXWfyTcWJqt/FiEFLmnW5flXoaDL0ubWEQAQz5/w/TyRFb2/FtTC/u9dbLGVbhbFK0
	oA==
X-Received: by 2002:a17:907:728f:b0:ab7:b072:8481 with SMTP id a640c23a62f3a-ab7f38745b8mr249121766b.45.1739363592260;
        Wed, 12 Feb 2025 04:33:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaEi4/FX10BdAWCbxkUVyuaMY7mEVoDH0yBTsxecDLYiaQqIPiFTwah+9QMZNjOq04nMflVQ==
X-Received: by 2002:a17:907:728f:b0:ab7:b072:8481 with SMTP id a640c23a62f3a-ab7f38745b8mr249118366b.45.1739363591806;
        Wed, 12 Feb 2025 04:33:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7cc737d81sm509138566b.176.2025.02.12.04.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:33:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B064C184FE5F; Wed, 12 Feb 2025 13:33:09 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Chandan Kumar Rout
 <chandanx.rout@intel.com>
Cc: Yue Haibing <yuehaibing@huawei.com>, Simon Horman <horms@kernel.org>,
 Samuel Dobron <sdobron@redhat.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: [ixgbe] Crash when running an XDP program
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Feb 2025 13:33:09 +0100
Message-ID: <87mserpcl6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi folks,

Our LNST testing team uncovered a crash in ixgbe when running an XDP
program, see this report:
https://bugzilla.redhat.com/show_bug.cgi?id=2343204

From looking at the code, it seems to me that the culprit is this commit:

c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")

after that commit, the IS_ERR(skb) check in ixgbe_put_rx_buffer() no
longer triggers, and that function tries to dereference a NULL skb
pointer after an XDP program dropped the frame.

Could you please fix this?

And, erm, given the number of reviewed-by and tested-by tags in the
commit above, I'm guessing you don't have any XDP tests in your testing
regimen? Any chance you could add that? :)

Thanks!

-Toke


