Return-Path: <netdev+bounces-149965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C49E846D
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 10:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99D12817A7
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E6D74040;
	Sun,  8 Dec 2024 09:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8518E1F
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733651371; cv=none; b=dW43st4VRnbXudJjCNORohxiw8X54yyPhPbeoF7zQmtJrxP1RNJ4BNDfttZVbBQuxAV6ohPpGFg7DsBhKYj+uGB5vRZeDxNi+pGFcA9UeXeM++lUfDezO9GWZ+ELDvaKM2nXRIFSvUVA7A2YUIf+ekWruUr3bsbP/8IQkrtvx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733651371; c=relaxed/simple;
	bh=ujgThMY5WseUJrjZtfOvc50Se1/6/RVuq2nWI87T4P4=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=s9OayMfqNvBp5hkFoekNFDIuoQvi1vteFcs1NB6+klWsLsWYA9ZhHkRO5T5dSie+PUB8I2vGXgOS/YeuyyrCLa3+uIYQSdUgRIeG+xTJaI68fCRWy89tXuMt+R2viLVWnP1M8d7sYQSQklQ6xyQ3rzdLlILaA5uN0OLkYa/APt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd71dc.dip0.t-ipconnect.de [93.221.113.220])
	by mail.itouring.de (Postfix) with ESMTPSA id 8B6A911DD47;
	Sun, 08 Dec 2024 10:49:20 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 3A28860189389;
	Sun, 08 Dec 2024 10:49:20 +0100 (CET)
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH] iplink: fix build on musl libc due to missing PATH_MAX
Organization: Applied Asynchrony, Inc.
Message-ID: <27de1ca7-659f-bf0f-e53c-5336245078a4@applied-asynchrony.com>
Date: Sun, 8 Dec 2024 10:49:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit


Commit a597ab1 ("iplink: Fix link-netns id and link ifindex") started
using PATH_MAX, but <limits.h> is apparently not implicitly included
by the other standard headers.

Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
---
  ip/iplink.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/ip/iplink.c b/ip/iplink.c
index aa2332fc..fbaa8c2b 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -22,6 +22,7 @@
  #include <sys/ioctl.h>
  #include <stdbool.h>
  #include <linux/mpls.h>
+#include <limits.h>
  
  #include "rt_names.h"
  #include "utils.h"
-- 
2.47.1

