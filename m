Return-Path: <netdev+bounces-92707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14A18B8584
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 08:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F786B20ABC
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 06:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954E4C624;
	Wed,  1 May 2024 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVWHXSp9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2B4AEEA
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714544182; cv=none; b=PsHms4HQCXlsREuWczCcrqxIb9r/zygHZDmxWvIhPLnZ42NUxHBgtOowy0WjLDkxvfq84zUcLrrcO7j9V8td0nGTSutTYyC4RZUOsnIkM/l4AHKT8aV971Lz1JwigJUXZf33vQ9Q/QecUZManm1GJvI5A+oMyZ3r22YxjRMM8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714544182; c=relaxed/simple;
	bh=C/G+Yc6lSL0KnWZgLpRAcyJTobCtF1C8q7WoAn1/w9k=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OAPWky9/PkGrNKtwcWnhXpaEE+2x1ThNq065UjssvsiFpK2Xq2ysQVXvbYzoAB5DuXFzrluFxvAazQtJBPujR3OAaxi6PtTbi7x5pAxgGSZb8KXNEr3+CK85LMmO+VLedCxLECEp4nx+/UQ8BurRKExBYZSaYbnsSM0oSUqDcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVWHXSp9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a2cced7482so1700904a91.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714544181; x=1715148981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlffWF4n7hbD7BhqroDTbKZiLUd8dai6pKeI2INO6F8=;
        b=PVWHXSp9/j/8xeVP6kvco8H0EMMmC+ETTfVhXXWhzNdVkolIdk2c4IBRVmz4rRzgQV
         bnRSptV0DIJY7Kzf8p+2re4A4Ga/wSHC35r2BttZlY7PlHESqow8qf2qbmP7ppDHY8OA
         NHQ32jND+8GrEtW0/znoyuGvh4Fgnjzl8ML1fHiWHGR/v5JHuJKx67XkUsHxOEx9hJDU
         CHDuYCw+FDLz64tHXt5ZMzGldRlgIR7DEDRm91nri2dujripOvXYpCQGW+JMK1Cq/W+U
         NO7pPBmh/qZblC+CM0yL6qWjqWZkXud2vmUlPMAA3069Ya31g0tBAtH9WP+okPMjNRNk
         rlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714544181; x=1715148981;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jlffWF4n7hbD7BhqroDTbKZiLUd8dai6pKeI2INO6F8=;
        b=e4W47ID8JR5C6HXXQ/tv3UwoLpa6GTeu6goJbU/QbwobbPpSLbaHL+gtGE5yG91anO
         trOaNZSPCxVcaDNfLYWYcYuvKQwzeoHPRRpaH9fRjFBPhSiiB+34zZgdsPt0wtDE+VBx
         b2AhmVZGiffbxvJXVDaX11DmwhiwFVuP2ghQIqrC24pPg+QzTYyr47IXrvAPS5Hlg1wu
         sSirXzKnmdIJpj451RVoIh/r8COBJUKq/MQatd8aYV9W3LI7LxvLG9S0fUQKCAxgKDuH
         pvcLgwmDxEDKbJI1scdBZtx3xdxK6L3UHvGXjedtb034umInBW4bLY/rsGKQ4i+smraX
         meJw==
X-Forwarded-Encrypted: i=1; AJvYcCXwnhlf3PQdjV0TLlYbk1jD9PdOgtxUuz/oU17GfFb5bZUgh2TFAb/xAOPwD3lBm2smqizmpV0nLNPad0Ev0ZLuExVAfQ06
X-Gm-Message-State: AOJu0Yx+ESuqEhm8o/YqQwzHQPMRkxDE9V+sjpidHqiKuchnbJtbeZcr
	8nvPaaTnu5iJX6XEl8oDkLATUE+hHojs46MsU0RRGR2w2aLyYVrW
X-Google-Smtp-Source: AGHT+IFu82mRB8FkyF/ipIIUPuCQe+xBuGafZqYbwUaPiHA4L1155QNSieWI65rPiu/x5Z5V+sCNUw==
X-Received: by 2002:a05:6a00:8998:b0:6f3:ec06:4997 with SMTP id hx24-20020a056a00899800b006f3ec064997mr1875311pfb.3.1714544180713;
        Tue, 30 Apr 2024 23:16:20 -0700 (PDT)
Received: from localhost (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id u9-20020a637909000000b006047eb9c7fcsm12994523pgc.34.2024.04.30.23.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 23:16:20 -0700 (PDT)
Date: Wed, 01 May 2024 15:16:16 +0900 (JST)
Message-Id: <20240501.151616.1646623450396319799.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v3 4/6] net: tn40xx: add basic Rx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240429202713.05a1d8fc@kernel.org>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
	<20240429043827.44407-5-fujita.tomonori@gmail.com>
	<20240429202713.05a1d8fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 29 Apr 2024 20:27:13 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 29 Apr 2024 13:38:25 +0900 FUJITA Tomonori wrote:
>> This patch adds basic Rx handling. The Rx logic uses three major data
>> structures; two ring buffers with NIC and one database. One ring
>> buffer is used to send information to NIC about memory to be stored
>> packets to be received. The other is used to get information from NIC
>> about received packets. The database is used to keep the information
>> about DMA mapping. After a packet arrived, the db is used to pass the
>> packet to the network stack.
> 
> 32b platforms are not on board:
> 
> drivers/net/ethernet/tehuti/tn40.c:318:37: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   318 |                            dm->off, (void *)dm->dma);
>       |                                     ^

My bad. Fixed. I should have found this warning in patchwork before.

