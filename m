Return-Path: <netdev+bounces-111832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9F8933587
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 04:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774721C226D2
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 02:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F826116;
	Wed, 17 Jul 2024 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KY3aGSPA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C0566A
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 02:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721184552; cv=none; b=OzDt2lS/uh5gkG/irQJzxIY7b45mFKs+s3nx0jZl1pINO7PEM3kKceKchY5PiwaH0t8m5ivPSXPGVezRcxeixTlG4kTdv1aDSQ9ifWYgGXGlxfr7SiSa+kQLGD51GsZcuHZFcPPGk9mf0jDmyahYs9YEk7RAfdTacSPH6E2+8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721184552; c=relaxed/simple;
	bh=j/I1SutNM+dTjzVVe/4QD8QLT1Mv1h0NTjNXCJC7I2Q=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D7dowHpUTJ/HFCfqfPiyS0yhflEbXRhWOfadpAE+EnKRgy3+vBd8W7wKMtnye7T0vjPq0sB76/Hn9B1CtXIxCGHtYX/Y/oBuSE9GRE1MUC1ZMl7TTH1fA7PEoxiqSOAo3FwZCwwXExnDsdTizugnyr2289bGC1N8iPWOGQ4yiVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KY3aGSPA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721184549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vni9TjBPN60/2WyNlkZNwO1ivJa78BWP+aNTmYi02o=;
	b=KY3aGSPADuofKLleTKEC6s3Uhv4l4V4psNOk9aRdqtxnYAod2rwSZ5pMYUSrx7GteEe4VM
	wn42dyXaf2nGZWazTm9gH38rWnylmCPIPw3w5Bg2anG2+D71tCh1acqN/8LjxhiIPp9K7e
	08EsIndwYtw3cP6hjdsmBTJhSKY9dy8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-YWcekGsWOe-wCTutpqNAZA-1; Tue, 16 Jul 2024 22:48:27 -0400
X-MC-Unique: YWcekGsWOe-wCTutpqNAZA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79f06a617a4so67720985a.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 19:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721184507; x=1721789307;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2vni9TjBPN60/2WyNlkZNwO1ivJa78BWP+aNTmYi02o=;
        b=O6gBAkKBri+L44aDBxoqENkHRWXfekEsOd62+joZ2Kj91j/FLOTBnHA+udkM7yLPgd
         5A859UWqv3ZusyLlTVAsTqEXa0VZVALboYXIe1mE/hIUlemTX1qmh7kksnkZTNnEYoAY
         s8ALpLrTDSSXRwbRhx/ZKJ0cQCnkKwSFoQ75keePCRL5Z5Xu+FRUCGmaLXP0M8XYZxdB
         SVH17ZVsBiFdEfnKuxQmb4YYyjXD2AcqykU/OxqbKC8bnuay3o8X/4bj5pIwbUBR6pjR
         3H/D1LN164NknkJHiHbhxlXNU1NN10wTOUxQDY1xDHoI/2Mhg7q9/NCCIQMME+/YfSM2
         8SEA==
X-Forwarded-Encrypted: i=1; AJvYcCXcNvY7LQmpDqdO5N4uj261otM6rt92QfMIcoU1TLTwvxQQmT3HCphrEFXZPdy94YABSwaQzBRUBChQI9Q5cX+GQcPfle0S
X-Gm-Message-State: AOJu0YyX0TZLsmH+KCKiYCTDINXyWe7w6+3Q12Rd5rL1pPAYPO+0PE0Y
	m2qFMQaymv9C5afNONljtryfp1YQS2TeoHdDLii+5QRoTsvMngPjU5l+kRqgb3T8bmGiOX12UKa
	KDe4t2fvFsWwTvKk0Aw9Ig12KG6TeK9Ri9koISoG5Ijc5xWSphj+elf3+zZ2LadkQ
X-Received: by 2002:a05:620a:205d:b0:798:db85:c9ae with SMTP id af79cd13be357-7a17cca2a08mr557423685a.28.1721184506956;
        Tue, 16 Jul 2024 19:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtxVXp+2Le41TvX6SHN2R1kXrRD0KbLIlks0MIb3Zw5n7C28EfSKrYdf3UZRQJU6HWjxW7Zw==
X-Received: by 2002:a05:620a:205d:b0:798:db85:c9ae with SMTP id af79cd13be357-7a17cca2a08mr557422185a.28.1721184506598;
        Tue, 16 Jul 2024 19:48:26 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160ba82cdsm352753485a.4.2024.07.16.19.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 19:48:26 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:48:22 +0900 (JST)
Message-Id: <20240717.114822.518449716597478345.syoshida@redhat.com>
To: tung.q.nguyen@endava.com
Cc: pabeni@redhat.com, jmaloy@redhat.com, ying.xue@windriver.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: Return non-zero value from
 tipc_udp_addr2str() on error
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <AS5PR06MB8752F1B379BB6B90262C741CDBA32@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
	<20240717.110353.1959442391771656779.syoshida@redhat.com>
	<AS5PR06MB8752F1B379BB6B90262C741CDBA32@AS5PR06MB8752.eurprd06.prod.outlook.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 02:10:33 +0000, Tung Nguyen wrote:
>>How about merging this patch for bug fix and consistency, and then submitting a cleanup patch for returning -EINVAL on all addr2str()
>>functions?
>>
> I agree with this proposal.
> 
> Reviewed-by: Tung Nguyen <tung.q.nguyen@endava.com>

Thanks!!

Shigeru


