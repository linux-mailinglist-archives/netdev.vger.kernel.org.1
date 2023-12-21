Return-Path: <netdev+bounces-59452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7296281ADE6
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 05:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3046D1F244B6
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3355C4685;
	Thu, 21 Dec 2023 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="cXtvqwZv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8996AD21
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 04:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7b7f2c72846so17836439f.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 20:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131819; x=1703736619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWqIkL0NhVcOS/rejU8Tz1LfxTxsSEyrlbD+eyP1ym0=;
        b=cXtvqwZvWTevOg9o+/lOLmBmmcEc/vRubLgoyOqswQLzHXQCmrzwtsjoyKiEjGYDJ6
         5yKXPLWrelV5/zlhf+19Halg/YVj9epgXADcreIvleiP731T+MGwAJ7Uxno9870dKhcw
         xjFJswxgYRkpiM7Xtz0dd4JAFfi+6kTZ17soFIkKEtwD+E+jJX/abzP/VAoGVQZJSKKB
         DVFTZNYQlaiA1AQ2uRqIWp7epNlQLTHicnkClWcwDCtcwsENplsthhsCjncSt/QJ2dV4
         9Eodc3ZB+OL6d4P0t41+ob95Mdc/ArFJr0uQJYyIc/9YGLV2AJYSEDuycckzIRZ3sG/L
         6dFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131819; x=1703736619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWqIkL0NhVcOS/rejU8Tz1LfxTxsSEyrlbD+eyP1ym0=;
        b=N0iN+SnHG+T0JFN2/v8nofLBGn6pu6xeD5JkHh4ehgxf4MhmhmDOD42HhIv1qTnjeH
         C/+m/xG2B5/SM18w2YiwRUq+4eP10Kz7D/lM3HaqNkNTe5265tdS7MAj3NDuXanWWw5a
         45qZbL3UOVvvLRgH0a88tX41mXlAKof/IRgeXEEie5e10GRDodZIfYHacJOLj+gGY12/
         87QSXQ/HbuqiE61ha7vdqAssUUOZW8JgJ6qtudU+aymSfWjjLPo13ordSV1L6GFlRWRh
         rKz1PYf+WfTvWHDIg0Uut9M2vJ+N8IE6y5cZndmiWQmpsgpJ9kAxFhD/5I/zcW8tzdaJ
         b+Mg==
X-Gm-Message-State: AOJu0YyZ61QDhH9sIAUdqaY3X+ZGd5eYzoxgGUH/KQ1Ogrz00X/awUmQ
	ay79JotTDtmoPihNqg3Hi8AQyQ==
X-Google-Smtp-Source: AGHT+IFXjCWeWk7A4T66xvSJZ+RZm3Eo8colLvS0poKED0d3nUr0WrOQBORVtjylOpmlDKTMSYiW4g==
X-Received: by 2002:a6b:3f43:0:b0:7b8:9d5f:6216 with SMTP id m64-20020a6b3f43000000b007b89d5f6216mr2881500ioa.20.1703131819786;
        Wed, 20 Dec 2023 20:10:19 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c24400b001d043588122sm520717plg.142.2023.12.20.20.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 20:10:19 -0800 (PST)
Date: Wed, 20 Dec 2023 20:10:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 00/20] bridge: vni: UI fixes
Message-ID: <20231220201017.0edeb8ea@hermes.local>
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:12 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> This series mainly contains fixes to `bridge vni` command input and output.
> There are also a few adjacent changes to `bridge vlan` and `bridge vni`.
> 
> Benjamin Poirier (20):
>   bridge: vni: Accept 'del' command
>   bridge: vni: Remove dead code in group argument parsing
>   bridge: vni: Fix duplicate group and remote error messages
>   bridge: vni: Report duplicate vni argument using duparg()
>   bridge: vni: Fix vni filter help strings
>   bridge: vlan: Use printf() to avoid temporary buffer
>   bridge: vlan: Remove paranoid check
>   bridge: vni: Remove print_vnifilter_rtm_filter()
>   bridge: vni: Move open_json_object() within print_vni()
>   bridge: vni: Guard close_vni_port() call
>   bridge: vni: Reverse the logic in print_vnifilter_rtm()
>   bridge: vni: Remove stray newlines after each interface
>   bridge: vni: Replace open-coded instance of print_nl()
>   bridge: vni: Remove unused argument in open_vni_port()
>   bridge: vni: Align output columns
>   bridge: vni: Indent statistics with 2 spaces
>   bridge: Deduplicate print_range()
>   json_print: Output to temporary buffer in print_range() only as needed
>   json_print: Rename print_range() argument
>   bridge: Provide rta_type()
> 
>  bridge/bridge.c      |   2 +-
>  bridge/vlan.c        |  38 +++------------
>  bridge/vni.c         | 113 +++++++++++++++++--------------------------
>  include/json_print.h |   2 +
>  include/libnetlink.h |   4 ++
>  lib/json_print.c     |  15 ++++++
>  6 files changed, 75 insertions(+), 99 deletions(-)
> 

These are all ok except the first one.

Please resubmit, and consider consolidating some of the patches.
Better to have 10 patches than 20.

