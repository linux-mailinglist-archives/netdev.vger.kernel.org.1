Return-Path: <netdev+bounces-115740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D501947A68
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E72A1C21179
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B94E154BE7;
	Mon,  5 Aug 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzIHncxx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827821547F2
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857701; cv=none; b=p+k8y/5gVfpU2uMBC003+fItovJ9zWZ7SmZyJ+hEu9wzB1IeB8zXTGNPlTL/gqM2Sow49Vu9ATwBUHzJP3jwAHF9txT6g2pUk6uV+yKxi5P6RS7ZsLHWIjRP32peexkAxm88olji47ko813+lesX7lsDQVdC9QNOIEIMA1T5WWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857701; c=relaxed/simple;
	bh=6Y4JDKG4aHSH1MqHkQvzFTtsjH60Vyfah5Bchm8bGY0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Up7jZs7PrvqToI4cJ6f+vIFmqCM4meV6EDl/AKdN2IR61conHt/u6copQd09f0VkJ7JXI8bc07QSCa5Wlzffj6PAqW7Ax47qynGJ5qBkDmCL1jzBwPpcej6cBFWyzmcvLmysZRX0wNifE+n6uOdeUqOoAWgay5xpQR/9UzxjN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzIHncxx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso70399365e9.0
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 04:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722857698; x=1723462498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXroJrPLEL3BlwT1EdHgkZ71OMvWXEukJn8uQuZmPws=;
        b=fzIHncxxs3l1hFb3CT+l7UT2QXIcz2BrGbMWvJmif7XrbYpf1cLnkZmb0va1lB2HDP
         m5ROW7czm8/wV49P3ySGIz6QaimwTUj0+CGGWFnm68mxELSwsCdUPtBTD1A9s8R54oow
         5eo/qwOUFSQIwGy0PekjoT9zwNnCiK+KDa4LfMXFPmOK/IIV//jFStHL7q8EevldiPiU
         TEQFRZpsNqiwhwj/cSwfeWKjcyL+MltJnlWKBOswVcaxhL8E1o+pMaXVMp0pOmCoHYql
         bW9F0b1BdByZNRRMZXdKvNvdM0bqhPCneqbG+wqd10oUry4AqhSer97kCI4Da7mV2jH/
         SGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722857698; x=1723462498;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXroJrPLEL3BlwT1EdHgkZ71OMvWXEukJn8uQuZmPws=;
        b=c7Qyp47BygNsm9GbOHH5EtZWqkJjCr9PwKur/AIUNTU3NO6+LCcBIJWQQtGEFfHKMc
         Lk3+s4j6BIK/m3teofIhRwvn2gSpmwsQ5O/9ePc+lXYF4edO7jA1YZjtBQSYcB1tCnQi
         wat/LxDW//03Ez7ExC5l7EQdMEo8/u2hv8gyJKsjJ7arf0+iC0lDXlDbidajDcd4MnXq
         PiX2wKT1cR9wTlQg7nCkt+k/L5BG40jzKuPeD5yNEiKmu5wfiwktrb04nPNGyA8OAbGn
         MTK2gcLQVITJOSZSIy8DCPzFowt/v6OWowjMY62LuWnkrOAU3lV7upDuRYpaH0Ed+39t
         7GJw==
X-Gm-Message-State: AOJu0Yz4KTamYB3Ceofa253FJwSHML1S5QR/tRuXfNxjuF7Bz59XXZJD
	91xRau8GxsHxQUzwu+6d27xMSSs6yfVUZ0xdxMOhF+fbyz2fqGka
X-Google-Smtp-Source: AGHT+IExwXV/EmLGBTmYIWgVGAJdcjBPCsrINKhKlLPmxwHkEmZCkHPlu+z/ZC4wgiphJf0lGPmgrA==
X-Received: by 2002:a05:600c:470d:b0:428:10ec:e5ca with SMTP id 5b1f17b1804b1-428e6b0870emr69870985e9.14.1722857697786;
        Mon, 05 Aug 2024 04:34:57 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb98109sm192991415e9.39.2024.08.05.04.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 04:34:57 -0700 (PDT)
Subject: Re: [PATCH net-next v2 05/12] eth: remove .cap_rss_ctx_supported from
 updated drivers
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
 gal.pressman@linux.dev, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-6-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <8550a5d0-a9e6-ec96-8072-20a069713f1e@gmail.com>
Date: Mon, 5 Aug 2024 12:34:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240803042624.970352-6-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/08/2024 05:26, Jakub Kicinski wrote:
> Remove .cap_rss_ctx_supported from drivers which moved to the new API.
> This makes it easy to grep for drivers which still need to be converted.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

