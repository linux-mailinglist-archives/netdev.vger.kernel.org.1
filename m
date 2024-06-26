Return-Path: <netdev+bounces-106762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A13917926
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0573A1C22B8A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CCB153BEE;
	Wed, 26 Jun 2024 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK8Ga2lk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D821FBB
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384449; cv=none; b=fJF2UyXPtaeWykVv3LFyjEE9rFkXZPKSsTVr/bJ1u/KUN2bVLpiuYRx18xQNZ4NGfX5a1c0UB/352/TSirGoCMgPkEmb316RUR2PJelVRksUx6wAUD69G6+tMb2F4Oh9b602GkM+UOKMhjYGKD0U+tnOunPacQUtgLmtH7F7GYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384449; c=relaxed/simple;
	bh=W5aS9cpjHDT5HY8kQt9EzD46BHSuxJTLftd73GrGc6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD8De/IwI5Ve6yTpif6FSCEJO6N97bO1MCpeuWeEIeCje4/w11vmHnTGL/5ZMIJH8e28q3G6a5MPz0waB9csKwfTXmsKKtYezD5Vmb8U3+RbjnkGhw9WXEphOL81ICP5mtZo2V5DXc14NTaLhrVV8bJp4x1BJ8/Ti7uhxoGu3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UK8Ga2lk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-70346ae2c43so171055a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719384447; x=1719989247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lggvHFrMrNzkUZV8dfcDUoNWtzYxzEYtQhehPZ/FhuI=;
        b=UK8Ga2lkTnWwRLeja9mkDLB3BwZ9vseZITMtnHpT8Cmb32krfYxx/qmBIhuddxdtRd
         4EqVQavcDZa/N3K8wt/iAGZO6kZHXwTTdGz91CojUS4PgS2ucNbAr0FJdyW368cyNvrT
         ZI1h/4F5kVqsDDTmwJ6cZgtM9dIn/WoZbEYpOnovRYkG9wchsOqQC9DEb/6cMvMoh58c
         khVZyS80924FeEr0L8ftBPAXnprOKHGkXCGajpocXPCnI5hVP+48pxyIE6Eey5CFJFgx
         rr7+IJsvuuREwwtkmuuHCVkv5adiEN1VUe7YOrBUvMb6v+sfMSlPtlB7PpmnJA0DpfLB
         PSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384447; x=1719989247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lggvHFrMrNzkUZV8dfcDUoNWtzYxzEYtQhehPZ/FhuI=;
        b=XT75ZH/ZqAuMrMXIjMvrCfBPDuU1DyLcSVzfuxWP1zgZiL4b6Bv6/pvrT7o684H+QZ
         MEMxKibBS/jS7JB+Nk6k6Sw49kz0+MQ6o86pZxKP5Yzdxlw7EHUFaHNRibh3xSSLlhb0
         59DziL/kvAMMXZImayzOCLBiDNye4Jwg+TPfflUvHw10iWlV3bhkiVhvEYU3Ya+cBBfY
         b2nWpUE0AVZwGhh2VsSBU5NAzCSBV8x2K9RgVcH3aKLvxRjqWdsdc+EahPoIlpo8UF+K
         1fKSKt5hLz6veM2aEBEoZm/B2dxIXeruU3b4U2HRWPVJDT4T0kW3w10zqPzrbsaHmOlo
         ydEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuzJiKKtynsek+d5wQ9YnW1yGmV3gAC7/v1cT0YJ6OGdCLg4CxO+lgSB96GYdYs58cSyFmPjqVcUVqsZKPbj9uyjj/iGCY
X-Gm-Message-State: AOJu0YzX12HXixzTERYT6W3LDjnD2xJCX4k/lndbONOzNJEDxpjILZMz
	EY4JAOK/PPip+kCqtsY9NzKqiurXmoHThaSbz6HQc+E0w/RAYCTj
X-Google-Smtp-Source: AGHT+IHBtU9uufzZWYYFAinEM+gl6wf4uwnOIurFxtq4BYrhzpOwhamrWnan7Kt2EO0pYqg9wm34aw==
X-Received: by 2002:a17:90a:c28f:b0:2c8:dc37:6258 with SMTP id 98e67ed59e1d1-2c8dc3766bemr888773a91.35.1719384447167;
        Tue, 25 Jun 2024 23:47:27 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d8061497sm830091a91.34.2024.06.25.23.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:47:26 -0700 (PDT)
Date: Wed, 26 Jun 2024 14:47:20 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 0/3] Multiple Spanning Tree (MST) Support
Message-ID: <Znu5eEoN3lRJxX5v@Laptop-X1>
References: <20240624130035.3689606-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624130035.3689606-1-tobias@waldekranz.com>

On Mon, Jun 24, 2024 at 03:00:32PM +0200, Tobias Waldekranz wrote:
> This series adds support for:
> 
> - Enabling MST on a bridge:
> 
>       ip link set dev <BR> type bridge mst_enable 1
> 
> - (Re)associating VLANs with an MSTI:
> 
>       bridge vlan global set dev <BR> vid <X> msti <Y>
> 
> - Setting the port state in a given MSTI:
> 
>       bridge mst set dev <PORT> msti <Y> state <Z>
> 
> - Listing the current port MST states:
> 
>       bridge mst show

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

With following steps:
+ /home/iproute2/ip/ip link add br0 type bridge
+ /home/iproute2/ip/ip link set br0 type bridge mst_enabled 1
+ /home/iproute2/ip/ip link add type veth
+ /home/iproute2/ip/ip link set veth0 master br0
+ /home/iproute2/bridge/bridge vlan add dev br0 vid 1-3 self
+ /home/iproute2/bridge/bridge vlan global set dev br0 vid 2 msti 3
+ /home/iproute2/bridge/bridge vlan add dev veth0 vid 1-3
+ /home/iproute2/bridge/bridge mst set dev veth0 msti 3 state 1
+ /home/iproute2/bridge/bridge mst show
port              msti
veth0             0
                    state disabled
                  3
                    state listening


There is one issue I got (should be kernel issue):

+ /home/iproute2/ip/ip link set br0 type bridge mst_enabled 0
Error: MST mode can't be changed while VLANs exist.

  If I want disable mst, I got failed as there is VLAN info, which is expected

+ /home/iproute2/ip/ip link set veth0 nomaster
+ /home/iproute2/ip/ip link set veth0 master br0
+ /home/iproute2/ip/ip link set br0 type bridge mst_enabled 0
Error: MST mode can't be changed while VLANs exist.

  But I got failed again after remove and re-add veth0, is this expected?
  I thought the VLAN info should be cleared after removing.

+ /home/iproute2/ip/ip link set veth0 nomaster
+ /home/iproute2/ip/ip link set br0 type bridge mst_enabled 0

  It works after I remove veth0.

