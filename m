Return-Path: <netdev+bounces-230640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D0BBEC32C
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D05B3548CF
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AE419DF66;
	Sat, 18 Oct 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="y51+tBdF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7322C72602
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760749193; cv=none; b=Quwxz9oWGHpJjT9ZlliqA4tMjvF3/6eAthi40wZiANyW/u8heZapg/uhVALAITk9ZLMmLiRa/rBFw+blnU3F/dZJFOlCsZ+XEZdch1/WQj02Z5xL9bAjg7ucvQ4UtTlQye5IaYUkNFdui/Omte/a2ifMCJLUhly6olp2iolLWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760749193; c=relaxed/simple;
	bh=s7nIw6m/HbsdzqZZwGNZbDYPJ8mHQOR6HT8rgAnGSL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0JxIXOCyLP1lKVjlvTN1aQrvcrPsrekD2uoUL1Y4agN2CkQBEXhV3GuxmHU36tKEjpag8gULddvck2g3Fbxr46Tagt4cAwvLBYDhuKCL6A22NtaNltG3InVa6spgcSM1IlOXKsyLpIYnzEUrUiWNwYlKtoUIaGvq2sCHj0rSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=y51+tBdF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33067909400so1964233a91.2
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 17:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760749189; x=1761353989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi9KLa2eoq8E3lab3hI9grIf4XP4pALHwkfRR4JlsOk=;
        b=y51+tBdFwIX7kFlU9i87TZV/OFe0TLElBBS7CjV0ZoSP4icOIxCULAj1+TDAxx9Yaf
         J0TvwpbVFu2csW27srRcAvT9um+usdws5C5GmxR/nNqBYh2XLkrGHjJ7ykwfB0166jiu
         91xO4+767jSi18mUyo5ouJ7xiMemLkJLZuyRHlB1bhRjKFb5NsOC6NzYFBFG1DiXGg7y
         9Lc2yWU39cM8HkCFjTjoJZRhMyGG1BeqSRQVo8CRBM57ZA6hWiFOW9w3Pm9Q7VE24gm5
         lomkkNIjS8ZZ0cbbe7FcaLONv6JHdyyUxNLEmEvssADeInAVlTZOBikYgvNvrR3OJaaE
         Q1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760749189; x=1761353989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi9KLa2eoq8E3lab3hI9grIf4XP4pALHwkfRR4JlsOk=;
        b=rZwcUvqGXjKIfQ0bMEJrMjGibHlbQrYeRGrFQtQSqWuA1syB0z5UgBbHiIqQjeryOj
         CnXpEhOKvmYsLm5HH4l85hRnduM1vv/5JnKuCuXPMI1h7anqwfdHN/nDm37cnjWS4OF5
         gaOFPoXkVjvqVxnx0GmtSsdjiM2EHC96Mcf48+eIWDfxiDZT05SnSWzN7cWjb2X5R4Di
         577FgxavcgHQCd9uI1VEIjaDYA9E06m3BfGvVIRdggE8d/iaeWZWnOhvDXj67xjeTnwb
         qspWWw6HAwYkOulNBRAw/UUQc0+2PZoNQ4wS8Vz7HYVUvgfDIwjqKSWgAKUgat06tEL1
         jL3A==
X-Gm-Message-State: AOJu0YyDbIr0G4KaRgdo4JOfBger2DkX/9XbTgAGfNi2hQAMM6AiG6A9
	00kIo+7QZgWf+97TcjKFDBLjp1248lq2cnE/1wZc7nMu8pecTHU3W6N7ZZKW6iKhOd8=
X-Gm-Gg: ASbGncux9P4du9Vp6PE9IpTXwXfI69puiM65K3CyiM8BNqhADlA7JZniTuTHdK9iMkg
	KlfIIux+b5NLsHjURB5E7fuoXWgITpzhYgSLCfKktObhj0UYU3qMGUArjy/uz6gqdiDVRZj71sx
	swAiUfQFnxS7cviVKLIcTYzaekDqY6fsknWEFDFse/s4/5sOGdT35iapcntpcPy9jJmBwynrHmj
	KOl2wK14q68bZ/IgUuCYUCmQXXlJ/yDxoW1fR1HEJ1Vquu0qckEWWg4Lkx8dHq5bFwk0NaCgw5F
	7SooBMTIltL9vsgm59uhCZNtirtfUNxqW1EaiS10bm1Z1J9rHKlQy02RBTSWSUjbnfaNTY6pkFN
	Sj1Q8FE9GAUhlrJL84/v5GJlS4cTmlnfS7CQGpkhNpha31l+i4ggkOIYMo++qX1rOyxbdDar2mP
	0ZXR2i9UJqaiZBhdZFqM8c+bOq4xNMb232ONj/tLAEMNA/dD/hGw==
X-Google-Smtp-Source: AGHT+IE8F7ExdklSa3ruJ5k8eRmpKIFS/XxjE3DOJhpY1qF6umrxCfc1xaeZyX8Dtdwt5OZutofUbQ==
X-Received: by 2002:a17:90b:35c1:b0:32e:389b:8762 with SMTP id 98e67ed59e1d1-33bcec2c587mr6060603a91.0.1760749189539;
        Fri, 17 Oct 2025 17:59:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bae284ebdsm3496550a91.3.2025.10.17.17.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 17:59:49 -0700 (PDT)
Date: Sat, 18 Oct 2025 01:39:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Garri Djavadyan <g.djavadyan@gmail.com>
Cc: netdev@vger.kernel.org, 1117959@bugs.debian.org
Subject: Re: ipv6_route flags RTF_ADDRCONF and RTF_PREFIX_RT are not cleared
 when static on-link routes are added during IPv6 address configuration
Message-ID: <20251018013902.67802981@phoenix.lan>
In-Reply-To: <ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com>
References: <ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 00:12:40 +0200
Garri Djavadyan <g.djavadyan@gmail.com> wrote:

> Hi Everyone,
> 
> A year ago I noticed a problem with handling ipv6_route flags that in
> some scenarios can lead to reachability issues. It was reported here:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=219205
> 
> 
> Also it was recently reported in the Debian tracker after checking if
> the latest Debian stable is still affected:
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1117959
> 
> 
> Unfortunately, the Debian team cannot act on the report because no one
> from the upstream kernel team has confirmed if the report in the
> upstream tracker is valid or not. Therefore, I am checking if anyone
> can help confirm if the observed behavior is indeed a bug.
> 
> Many thanks in advance!
> 
> Regards,
> Garri
> 

Linux networking does not actively use kernel bugzilla.
I forward the reports to the mailing list, that is all.
After than sometimes developers go back and update bugzilla
but it is not required or expected.

