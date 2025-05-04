Return-Path: <netdev+bounces-187655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A338AA88F4
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 20:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269D77A8A41
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 18:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB092288F9;
	Sun,  4 May 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nOqZ+bA7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4F91E3DF4
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746383163; cv=none; b=S69I+hGA7XugUfzVkZJ9Jd6K0AbBNvdrOgERPQK9h5qp8pR+baq/biIG5jH75ttb1ZCOm4w5IvK7yIC77q/Xf1ClWIrAoK/K8NUNQ0SETmLKYV2wkIUVBI8/i1gzsNLdGijiNEE3t+0SQtDqi8uaslRnChnRkA4X2ttCfrs6QsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746383163; c=relaxed/simple;
	bh=Ttb9pGU52KbP/Gi0qQRsBnn/htY1jF2pYg/UZNQFNiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7NA+QTQX0WFEA0XtDI+maNxj8Z/CMAcB/HdpVcu65QO3W98lTtuYqmIio0VildFtTo5zXuSNZU/yqxUmN50Tu1udN6RS7KmA12LPU2SwfUFugOhXsgq+BJwk1LwDw+HvYNOIqWxy0cqK1GEHCLG+DbkhKoAOKnqtdKbVuPorjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nOqZ+bA7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441c99459e9so2781595e9.3
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746383160; x=1746987960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ykb9eijUTkzhg09i9ou1b6h1AIPZKplXj2SXTCpdWIg=;
        b=nOqZ+bA7/3NYXolTU/k6m6fA0rSLbs659uOheRLe02TWtDbFrzGHdNHxYqA3voOuHa
         /l/muGmL9SnHTIaVg2PIFPJjlEtTNelpgvfR1ZgdZ2j2xdMdYNv0Uvh71V9Zor/XaJGC
         qPHo3SMNpZ28q8wwKjm8VXqUcnfdrtKLICkAI6kDDkFoDhXBWZ698icZp9f03YXmGgHA
         sItuUYdfiXaOQsuZ6ehha04D8SteAlO/WJuCjFL6EdHHMu64IoRisRU9cZB6nMO63bQS
         8v7YBH/w2pZGm1eHULMDyPKN+AbzWJfe9fFeIuRQyzn4FtmGR7bgga7C0dKnigh9fbTV
         r4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746383160; x=1746987960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykb9eijUTkzhg09i9ou1b6h1AIPZKplXj2SXTCpdWIg=;
        b=VLs9n4AeNxVmbgHpe1sq41HprvP2wOiNqKmGOJ9fvb4XL3j/chTDG3MlR9WLJA98s9
         U7gVnNNfLAVIzuYX9w0miX1BlFDlgTmcU2stS1QrjUtO9HYIBW+lyGjfiPN9cmQ/kJ/u
         AcwAlR/FSq7lXXYFlmdZiOmxwEWAimMKj/sdUdilWCd67ECRKH98DDDyL+HtDT6AcJHb
         iE2/Uj+rA75zYejvCoVhsUgS0mQseO6B+iak5zqbLYzat4b47gT6R/r4iciitv8CAgE5
         fBt2BvRITdTwHCgw/m5mkK+5pPzAU5lmJXe62kxDse3nr++p+8hMb6+7EN9Fr5vgS6s1
         1DkA==
X-Gm-Message-State: AOJu0YyCeVECUJYIM9/MsXpu3fLHfbx4BUQes2PoreZ7qDANodE7Wa6i
	tVHJF4PEBsdcOpO3IChMXqmZYV7lcnxQRn8e7kvJ/nCZ3qDQts7Vk3ptuJ90xrI=
X-Gm-Gg: ASbGncutEbz0+tYtYjLUtT8mgeZhlVmkZKfLOmqrDRD4Yq+HjoNrjEVebXAtUMzV1qi
	P8y1jOTTcU5D32KF3j8sUr6soMWQQMd4vn9L3yo90FENCpoUPxQStcJrr/NwFs5xEZJiTuLt1FN
	ZnQmLtQQlQxOmX/y8WM284iLjsRCBdaQG+r0s6k88T9ZrvoWCcxOmc/M+mNb52lhjlbJmIIIo3l
	NajqSo+V+dSghP7IeQjzJ94lFu6dPQz+OU5pnZG9zVMDGR2DIcf53BdJ8dmj7ID66dLGNtiaK/2
	i4zRNVC694u9NoHvzme8oWLsrtj/OeJwxOhFW9l7aiekbL2g0bvm6Wtffpr+cPlI2TV3udNQEeX
	gfYk=
X-Google-Smtp-Source: AGHT+IGa0+v7lq/wfz48tfpY89VoC6ahg/aLFhWbbHORTi3byQkIL8tp1tstzf7RYSaoE6FUUkUz6A==
X-Received: by 2002:a05:600c:1d27:b0:43c:fa0e:4713 with SMTP id 5b1f17b1804b1-441bbea0ce6mr89455855e9.2.1746383160267;
        Sun, 04 May 2025 11:26:00 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d199bsm107845355e9.14.2025.05.04.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 11:25:59 -0700 (PDT)
Date: Sun, 4 May 2025 20:25:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, saeedm@nvidia.com, horms@kernel.org, donald.hunter@gmail.com
Subject: Re: [PATCH net-next 1/5] tools: ynl-gen: extend block_start/end by
 noind arg
Message-ID: <dck4fhndgfgvue2bho4i3rf5r476hxhnh6pgvahmmevtvrlbrs@iyihhv6vb6ia>
References: <20250502113821.889-1-jiri@resnulli.us>
 <20250502113821.889-2-jiri@resnulli.us>
 <20250502183720.15a82e29@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502183720.15a82e29@kernel.org>

Sat, May 03, 2025 at 03:37:20AM +0200, kuba@kernel.org wrote:
>On Fri,  2 May 2025 13:38:17 +0200 Jiri Pirko wrote:
>> -    def block_start(self, line=''):
>> +    def block_start(self, line='', noind=False):
>>          if line:
>>              line = line + ' '
>>          self.p(line + '{')
>> -        self._ind += 1
>> +        if not noind:
>> +            self._ind += 1
>>  
>> -    def block_end(self, line=''):
>> +    def block_end(self, line='', noind=False):
>>          if line and line[0] not in {';', ','}:
>>              line = ' ' + line
>> -        self._ind -= 1
>> +        if not noind:
>> +            self._ind -= 1
>
>Should not be necessary, CodeWriter already automatically "unindents"
>lines which end with : as all switch cases should.

Got it. Will try. Thanks!

