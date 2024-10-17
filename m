Return-Path: <netdev+bounces-136600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086689A2472
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298CA1C22997
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81361DE2CF;
	Thu, 17 Oct 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC55YWZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1991DDA39
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173792; cv=none; b=Wa98lYrb28xwRv1lvrovg0KXrDnoeQXezPHKW1DlaG9Uva+MjyTYYrCDWKj5RrHuQcECiQv4RCkX8G1mUkpV6CvKHixPLFjXEqvuy/dJYIU3d4PbOKPudSC4/SubINGp8ZqGCcSuGCJA2ZnpMBHmfhddNygb1ichAi7L+ugQcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173792; c=relaxed/simple;
	bh=+FFSy9efMPz+Q41rKxQztvgrmi06idCSUyvQPHkUOj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a47XpiPwoxqTmMU15qz2qJ/F96JEYD9uPwlh7sGg2lrhVWT8v4HCeTQdcxPu6t5YHCT7ndBPR58mPaOzg/YjE+bRRnfLUh/uStMczYrG86KISM07HZqyXVcHVdwRSVo9QfFJZPEcnMXRSS8ECVloOuAjV1vjW3lh8We3kok1nSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC55YWZx; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7157c2aca3eso501303a34.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729173790; x=1729778590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FFSy9efMPz+Q41rKxQztvgrmi06idCSUyvQPHkUOj8=;
        b=nC55YWZxjQwfYg1sC0ClvhjFJm9/ZbKpsLg8YkC+hqaSkQDvnq5E8lH3FQ9o/EUMWJ
         1UWUb3kwBHoIvUpIzcfMMVXwLWUES+vXH7UqJiDXhaQhfuhbv5xmoegtADpwZbMKtkw1
         cMsBYmXPnbGMCh7w2qU1AKjJyUpCEoe/jV/hIfp2mnE9K5RBI3+tfKkFanMKBJiPqz+Q
         YXojxD8Hgp1HkvN92w7Bvq276wheiVm2rdJBvzqiHz51bxj+GuvhVTAVQDOGXHWvUTBW
         IZjreh2leCu9vAQriIv5DTSgDnLCcuyEwOi0TjvHM5ifKuRVwMOQluIifRc/8P7k+10k
         Egcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729173790; x=1729778590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FFSy9efMPz+Q41rKxQztvgrmi06idCSUyvQPHkUOj8=;
        b=Ni2pHF2pinKAAx4DdfrOuOcark/HGKx9YXdXpMmoGadgK3hu+vl35Lo2j0NcTt6Oo2
         XQ/vrF7CWBjOIYx2F+Z6aHyrLHCErDRhQt5J+b7i+yJ+P7utP92nf6+awmcuek4vLwIF
         9E/+b/Jo82LhQl7+y3c8ilaP9GXmjKTRHyUJKeLdcJYM4QHKTRX+KdIngFeurk81WnAP
         Ldp1p1pF/6DLxOt1yyQ+ZolwE2qn3tKKAEoE2f+sZ3gdbS60Oo2OVBvJhOLWMblQIAI+
         Jzv8hgY6/eefrQdZ9jwkyao62Vt2+Q13zXzR0SghTgTqDdGXWVpO6iusCqzNKkEmHwyz
         omNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNZrdMH7DN2ega3tjRlIRxpO5/mXkcBlrrr01WjorhZxlkAn9pt9TMuiHkSAh9rQJq8hyLMF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWYBCVngiQuMcLSw9nQnAQsrhR8oSq3XqcB/8uMgAxTUVNgxV
	XgSRAvI3FFMAOof8tjJhryGHCX8N/F1qvbchPIZP80PzZXmniDMO
X-Google-Smtp-Source: AGHT+IGqwiGxNzMY2aov/Fi6O6O/sfi8OPg3uvEuxFQq6gNQdCJWx4W9v8bMe0DM1Lu1z/SP5rlV/Q==
X-Received: by 2002:a05:6830:6f89:b0:717:d48c:593 with SMTP id 46e09a7af769-718034971bdmr6743230a34.10.1729173790349;
        Thu, 17 Oct 2024 07:03:10 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7181582a096sm73006a34.18.2024.10.17.07.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:03:09 -0700 (PDT)
Date: Thu, 17 Oct 2024 07:03:07 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv2 net-next 0/3] add gettimex64() support for mlx4
Message-ID: <ZxEZG-sPkXP2br2V@hoboy.vegasvil.org>
References: <20241012114744.2508483-1-maheshb@google.com>
 <5b614738-31e8-4070-9517-5523b555106e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b614738-31e8-4070-9517-5523b555106e@redhat.com>

On Thu, Oct 17, 2024 at 11:22:12AM +0200, Paolo Abeni wrote:
> Additionally please fix you git configuration; you should set
> format.thread=shallow

Yes, this ^^^ makes review much easier for us.

Thanks,
Richard

