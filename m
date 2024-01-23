Return-Path: <netdev+bounces-64988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2655838B76
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F7A1C21DB7
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB165A109;
	Tue, 23 Jan 2024 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtJF14n0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D95A0FC
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004853; cv=none; b=XHVqjWbv6Wtb+NI85Bnefylo6hJGZi6cR0wK9cyJKkhAMqG/sssJJUBKoAOPJ6ntIjg7+z5H5OCqsrqAizROJVKbYt/NwZjbnOv9rQUwSbpdrMAgdxjBlpEv15Y76pS2KOAIO/GHxCuUNZ3UoZW8Q2/N9MxQCOfOTGoq3WO64v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004853; c=relaxed/simple;
	bh=gs+QbCqNiikPj0gLJvTBbE6TnYyU9UjU3AFyG2oFktg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tYpcDkmXJvkgkcN2nx+b2tpt3imm00q6NQ3DDFXN6i7D6mc/OqrXuetljmHOqn6cq+zFBearRr+73NDFd3Q8XCRZWYKGtXGNmtXFyI9oiNmazeHgG9UxG0vAZLPX0nZrXX6/mrhT3ifDVfPD27Xmlmz1u/9VIhpl+PLbaDLr+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtJF14n0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso53051995e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 02:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706004849; x=1706609649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl0txdoX5ubX9q6e6WExjH6NlAxL+YsMy4sstOJvAik=;
        b=NtJF14n0aOOkmsHf2yCEpnmT4IvGXPqgX0icJiSvmARGDLXqlw8wehgClNe3Cag2sG
         JDWl8TQ6BZwaqwQ+C4SkagPBzuSAVgRpVduWUjXkyga+HQNUYc+XtQ3eZvQUKE6uF9gZ
         DVlpN/Iy8y+ZE87AMMDSr7HwWvFVaumESzsHSoX2ZL4OFBOMQxWXyEdrCbzQ/gJB3CG5
         TldbdTjKPrkAAMd5sliiU85oAMMIN07HrWAJFl4ipj77gRTcvU/vKJau5EWE9aPxHuPd
         BhpZDpkUrQNsalCrPAweIaVaCAUqQurtDxtbkd2dFGPH7dkmcvuzutPslbR9Yr8uMtLg
         dKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706004849; x=1706609649;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl0txdoX5ubX9q6e6WExjH6NlAxL+YsMy4sstOJvAik=;
        b=dBr+TxeGT1pnaO/qZBI0BUT3NRuNWkh+HqyJiB7RSkbWrK+NBp8kJDBQBtOF3u1yt0
         3soh0lMyecimZE54gyAECb4G+76M3OgseuIpd5q7ZMrEINPPazolq4m9Mpp701hY7+3q
         am2XHmtBYCKvmste6DPYaVsMSHi7wdX8WBbVUMXKVs2nEz8HYLnvetltqRu1LI8bld2U
         us9NUQrgRXGuRaTR5z2J4LsknCOy07J/T/jomzDmuGM3GfnJ93/EBVxmGvOg63XViDG4
         l0O/o5mLJRL8kagudkHVrp5Jr7GjWEDzjSmbPoteCeW/FIB8cO+AkrAMvOTCN+OJG1qy
         i8fg==
X-Gm-Message-State: AOJu0YwSrzOGGILrOzkXZXKABvh2tnpNU1tPIduvR1w27ik++E2vwaX7
	rMMgNX0kHsD8+amo1aABU9TOWpE1ydwR3YnxKr3eRV+rxivUj2c=
X-Google-Smtp-Source: AGHT+IFdWvq+sPNPZWWLC7sV0PhebLTgL0c1UNXu/SCN0X19PiKoV/CT5ThwnXpyF4phCo1fPjinpg==
X-Received: by 2002:a7b:c043:0:b0:40e:3fa2:a16 with SMTP id u3-20020a7bc043000000b0040e3fa20a16mr380480wmc.201.1706004849433;
        Tue, 23 Jan 2024 02:14:09 -0800 (PST)
Received: from p183 ([46.53.248.133])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600010cd00b003392c1f40acsm7281332wrx.28.2024.01.23.02.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 02:14:09 -0800 (PST)
Date: Tue, 23 Jan 2024 13:14:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH 1/2] connector: fix #include <linux/cn_proc.h>
Message-ID: <2b04a34e-d049-497b-8d5c-3602d889ab83@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Including <linux/cn_proc.h> first line doesn't work because of missing
forward declaration:

In file included from kernel/foo.c:1:
include/linux/cn_proc.h:32:47: error: ‘struct task_struct’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
   32 | static inline void proc_fork_connector(struct task_struct *task)
      |                                               ^~~~~~~~~~~

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/cn_proc.h | 2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/cn_proc.h
+++ b/include/linux/cn_proc.h
@@ -19,6 +19,8 @@
 
 #include <uapi/linux/cn_proc.h>
 
+struct task_struct;
+
 #ifdef CONFIG_PROC_EVENTS
 void proc_fork_connector(struct task_struct *task);
 void proc_exec_connector(struct task_struct *task);

