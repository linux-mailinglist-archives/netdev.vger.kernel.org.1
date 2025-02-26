Return-Path: <netdev+bounces-169893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DF8A46466
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC67174717
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28144221F02;
	Wed, 26 Feb 2025 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaRCEFMi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC820C008
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583123; cv=none; b=rWRDE5SBsRLGINpr0NlV335wKqTj00UEwG2gupbhk5rFBqHBb09JXb+5KWGNZhvQCCUvVENzlW77Zf1pI2tPgZinycm9MrMI+MpP20ALr6ovLVGSDCv5wbSl5po+4E9k70R4j3Npflxnc8ptT6zjSYs3ZEQZES4o192+bTMU3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583123; c=relaxed/simple;
	bh=uZqpKRmZuulFM4M5k1miaq/vOU/5yHFwnDjpEDDJ/kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGTHg9Y/7+DriUpGudj9clqPrMfoc/GYjjE5hAuqULnGP1LrTVRmRAwjYZOmUMhkU4lFD7BMdRcIcke+YmoyRnyh+7f4uD+MUbjXwULd5fhiHLD4fRaB5oKjP41WiR3SVDCDuAhwtNt1mv8SmbTk+WC8uLYeBdBwhs97lM8burQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaRCEFMi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740583120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZqpKRmZuulFM4M5k1miaq/vOU/5yHFwnDjpEDDJ/kw=;
	b=BaRCEFMi+yFtfuh18h/TZieaPKa2cWGqVUd3FUIrMYKWRlyCylR+PS4XzTRDIsnYrkZvgX
	CgL+g5MAuRi9e89mOtedkVnYFfQTCRXouJ2bo9at8naQYeR30Ups2dRfbagGybmehZnu4b
	K/DXrsA0dfjgwM3w0gAMsQ+oOsNdpLk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-aD2MXcrDNwiHzsdoKWlpfA-1; Wed, 26 Feb 2025 10:18:39 -0500
X-MC-Unique: aD2MXcrDNwiHzsdoKWlpfA-1
X-Mimecast-MFC-AGG-ID: aD2MXcrDNwiHzsdoKWlpfA_1740583118
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-54531d9c128so4190967e87.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 07:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583118; x=1741187918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZqpKRmZuulFM4M5k1miaq/vOU/5yHFwnDjpEDDJ/kw=;
        b=HVjurwRJNfQwbpV63yMjc+HrTlGo3tOfYwWi3Vz1J4z4TIADNk0s3TIav6QJY1vGIp
         kGeUhX2JgFmGAkGPAGYkXpFSNDdJFPgR5hRzX8ajhy3NURUOpXmKRxFTxpJINQPJT92A
         4aCIUDsecK6s7jNtzfOp1j0NlfWfWosghUhmt55dj3m4yxMLM1Ygj12A35XbCv/SG2uT
         LDwQ8Gv/FsvvhofOqqmz0zclhpYKRRBE6BfOH7v8BKSDagyTB6/cUahiJz1w7tB6qOCf
         pYTyq3kL/mmgfzbsyQe9mGyyTFK0Srq6xROKySwTsQSMG8ygmD9lgyQPh6HJc287M+O/
         53Pg==
X-Gm-Message-State: AOJu0YwTRNBtH1CE5sk0E232DWi3Y/PNRYuiYavjomJhdggYn/MThq4h
	FUt1Wi2czPJVX6OfHjoCIfN6pnBVkeycWI7+zeFNr+HpdFCRh5uy7jtqNb4hmRiNY3oBFN/9u64
	NPsGwCUG+jLtA2Yyy1OtLCq/oxsfdhQ9HXQkCVvefVddkhbEWYBWvVw==
X-Gm-Gg: ASbGnct3vcttdnDLO8dLjkDrTMNqelMMs3SkhVgo+yjwtw01oDgT9gUgmshxKU7TiAx
	CGalsD6D3ncQIChGKvlyrmPF7CBsULK4zXBGoyDRrP0yy6RNDucAwoYlytqxHkxe9/YMTF4kaot
	JDA/kkd0VsNBH4iZG/XyLqig1TP45JZvuUckSQPJFK0cxCLxrTJZVuvLXrDvbPSfQqE3+Asjfr9
	E2WJJte4WXEgd+RK8G/tkrXbQFpimFm9k1ohEAJDM9XKJr0Dawb6ZfuOcOgIAfuBxPjpXa+JWRy
	ZIQ=
X-Received: by 2002:a05:6512:ba8:b0:546:2a27:ec35 with SMTP id 2adb3069b0e04-548392598c1mr10885731e87.37.1740583117637;
        Wed, 26 Feb 2025 07:18:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8cCV/CTAGNY1mRdej5W9AITBY3gWp8o5Gg9KdFUpKILkLXTUkqOfoBLoJXygHORRQPMT/gQ==
X-Received: by 2002:a05:6512:ba8:b0:546:2a27:ec35 with SMTP id 2adb3069b0e04-548392598c1mr10885724e87.37.1740583117220;
        Wed, 26 Feb 2025 07:18:37 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f4d12sm476249e87.162.2025.02.26.07.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:18:35 -0800 (PST)
Date: Wed, 26 Feb 2025 16:18:27 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
	petrm@nvidia.com
Subject: Re: [PATCH iproute2-next v2 0/5] iprule: Add mask support for L4
 ports and DSCP
Message-ID: <Z78ww29QI4X5bI+o@debian>
References: <20250225090917.499376-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225090917.499376-1-idosch@nvidia.com>

On Tue, Feb 25, 2025 at 11:09:12AM +0200, Ido Schimmel wrote:
> Add mask support for L4 ports and DSCP in ip-rule following kernel
> commit a60a27c7849f ("Merge branch 'net-fib_rules-add-port-mask-support'")
> and commit 27422c373897 ("Merge branch 'net-fib_rules-add-dscp-mask-support'").

Reviewed-by: Guillaume Nault <gnault@redhat.com>


