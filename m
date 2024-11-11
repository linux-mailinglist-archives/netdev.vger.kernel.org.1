Return-Path: <netdev+bounces-143841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228039C46C1
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 21:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A860C1F2791A
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 20:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B01A9B3E;
	Mon, 11 Nov 2024 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lo1J19ZG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED919F46D
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356757; cv=none; b=s1sFgsWXXJKXeOSr3RX3U3PiuZlpf6QpijEUFONjfL72j9Odkeijj6VBbPCLuAF5vqN+jn/d/pFU/RhBncRALvWEgYkYUAnOcwbZ1tTdjLUkoz0AkDGKijRCA2brM+qHC+gvG8y5rqi64u5H5mklewhuGMriF6CXHxe0+n1hWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356757; c=relaxed/simple;
	bh=2w5AOiqqlQUI7ff1yMnJ4pyBjIIdEcmBrtd1H9hIT58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQoV3759cSJnS/45JW2/y3xarYyMGS9y0fomDOdqBbHQHNE9LVHpfzofkzKNlFwAnMn/LTYlKjenIs6cw1cht3wTLttMa3phGpov6DqyHitn0XbFJYFVBpe7WwPDDY7DZjJIrZEybWj2nXh/l72lwA6yrzq3RmQ3J/zOHga30LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lo1J19ZG; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ee386ce3dfso4492184a12.1
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 12:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731356755; x=1731961555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZedqqjyJeumj8+2BRCMIUVijoRFqC01LDMvINlLK7gQ=;
        b=lo1J19ZGSgA495tA2c6mV5GqbRO74mxxvWhVuWWvlrgoywSQL0AqvOssfzc/I0vABN
         hsKoRixtiL+VDzSKe/nzUdhdyQ9PFtgpn3PmUXv0T5DUKvFpiH45zCkaGMOcaikycVDJ
         MF8cyvBO33Bd5VfV1N/54oqUQFPl/OnhTYZvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356755; x=1731961555;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZedqqjyJeumj8+2BRCMIUVijoRFqC01LDMvINlLK7gQ=;
        b=Fp7LwrU7qfcfBOB2ZawON2rdIKgusXslmgHkCeJAfGUKp+0qjPSjnX8BUF9fGUwxPh
         6OcMP315MANK8inIEnmTeVNrLY1J4SUThaN+XIWDU9UJN4sgms+TCZYfgcWCQ0tvP9A+
         zTkVjLWqh/C4yiWVz0f9m5vLth/8E2vRqMJgicuW3VPhrihb9VMXQ3pb0Hfqx3H7aKej
         9iqeYH5c9Hddb5m3Mz5eLLb4EGyp0A6LDI7QcPHc6ybCrtKO6O4E2HusltcLc/W5eNh8
         DqopS9/7Lc6EUCvuQrCRF0n+PbzT6xfiJ+lECwpvL00bpEwdVeN/SwFO/QQFEoC2IJQX
         dq2g==
X-Gm-Message-State: AOJu0YwpqDmnb61YXozBurYia2DUXjGPvTgwmi0GymN9dzH5zaumFcdL
	vr6GsEEvX46HhcrwGx0Tn/oHrgZpSrJ/BbSQu3uuatlVtlX7WwiuZ4xTplq1dEA=
X-Google-Smtp-Source: AGHT+IF2Ru2h4ZQi9WWUaGkF59QU53pPfGyKW8tnYpPW+BjO0RHI3kunAeHAUy1Qepm/XqDiyw7M7g==
X-Received: by 2002:a17:90b:33cf:b0:2e0:7e80:2011 with SMTP id 98e67ed59e1d1-2e9b0b381efmr19863855a91.16.1731356755368;
        Mon, 11 Nov 2024 12:25:55 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7f3esm79470755ad.24.2024.11.11.12.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:25:54 -0800 (PST)
Date: Mon, 11 Nov 2024 12:25:51 -0800
From: Joe Damato <jdamato@fastly.com>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] eth: fbnic: Add PCIe hardware statistics
Message-ID: <ZzJoT-YLUHuvK1wk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com, andrew+netdev@lunn.ch,
	vadim.fedorenko@linux.dev, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111195715.1619855-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111195715.1619855-1-sanman.p211993@gmail.com>

On Mon, Nov 11, 2024 at 11:57:15AM -0800, Sanman Pradhan wrote:
> Add PCIe hardware statistics support to the fbnic driver. These stats
> provide insight into PCIe transaction performance and error conditions.
> 
> Which includes, read/write and completion TLP counts and DWORD counts and
> debug counters for tag, completion credit and NP credit exhaustion
> 
> The stats are exposed via debugfs and can be used to monitor PCIe
> performance and debug PCIe issues.
> 
> Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
> ---
> v5:
> 	- Add missing fbnic_dbg_init, fbnic_dbg_exit, fbnic_dbg_fbd_init and fbnic_dbg_fbd_exit functions
> 	- Add missing entry in fbnic.h
> 	- Tested on 1-NIC 2-Host system
> 		- Test Logs:
> 				Without ping <remote_host>
> 					# cat /sys/kernel/debug/fbnic/0000\:01\:00.0/pcie_stats
> 					ob_rd_tlp: 88724
> 					ob_rd_dword: 1363273
> 					ob_wr_tlp: 980410
> 					ob_wr_dword: 105006453
> 					ob_cpl_tlp: 98665
> 					ob_cpl_dword: 1363273
> 					ob_rd_no_tag: 0
> 					ob_rd_no_cpl_cred: 0
> 					ob_rd_no_np_cred: 0
> 				With ping <remote_host>
> 					# cat /sys/kernel/debug/fbnic/0000\:01\:00.0/pcie_stats
> 					ob_rd_tlp: 114081
> 					ob_rd_dword: 1902295
> 					ob_wr_tlp: 1098457
> 					ob_wr_dword: 112936622
> 					ob_cpl_tlp: 128409
> 					ob_cpl_dword: 1902295
> 					ob_rd_no_tag: 0
> 					ob_rd_no_cpl_cred: 0
> 					ob_rd_no_np_cred: 0
> v4:
> 	- https://patchwork.kernel.org/project/netdevbpf/patch/20241109025905.1531196-1-sanman.p211993@gmail.com/
> 	- Fix indentations
> 	- Adding missing updates for previous versions
> v3:
> 	- https://patchwork.kernel.org/project/netdevbpf/patch/20241108204640.3165724-1-sanman.p211993@gmail.com/
> 	- Moved PCIe stats to debugfs
> v2:
> 	- https://patchwork.kernel.org/project/netdevbpf/patch/20241107020555.321245-1-sanman.p211993@gmail.com/
> 	- Removed unnecessary code blocks
> 	- Rephrased the commit message
> v1:
> 	- https://patchwork.kernel.org/project/netdevbpf/patch/20241106002625.1857904-1-sanman.p211993@gmail.com/
> ---
>  .../device_drivers/ethernet/meta/fbnic.rst    |  26 ++++
>  drivers/net/ethernet/meta/fbnic/Makefile      |   1 +
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |   6 +
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  37 ++++++
>  .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  68 +++++++++++
>  .../net/ethernet/meta/fbnic/fbnic_devlink.c   |   4 +
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  12 ++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   8 +-
>  10 files changed, 278 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c

Just FYI this patch does not seem to apply to net-next/main. Did you
rebase?

