Return-Path: <netdev+bounces-48404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E327EE3CC
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA30BB20A5D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F033CDD;
	Thu, 16 Nov 2023 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0Vixn94"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B1D6E
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 07:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700146926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6L7tI+K8yZDrsftYj6Ia4FnBkfs6t8tIYhpG29gA3U=;
	b=O0Vixn945OZSdfQZRZszGHMCGE1V+GAIvslg2VunIK0jtUThtyv/fZalOjsvebJ2bVqsgM
	woikufx5UT8uz8cTnMnSSRpHNAb3IcGiJmYM+Hpa7tiurK6knL8XAX6v2m/B/qNLJjA/N0
	0uka2Mh0lGZ7hArTKzp4xAHSza+0iY4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-3hkXgPN0PXqpqicqpF-54g-1; Thu,
 16 Nov 2023 10:02:01 -0500
X-MC-Unique: 3hkXgPN0PXqpqicqpF-54g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 737161C0651B;
	Thu, 16 Nov 2023 15:01:56 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C14265028;
	Thu, 16 Nov 2023 15:01:54 +0000 (UTC)
Message-ID: <c14fc17e-95a7-47be-86c5-e1c889ea627e@redhat.com>
Date: Thu, 16 Nov 2023 16:01:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/5] i40e: Simplify VSI and VEB handling
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, Simon Horman
 <horms@kernel.org>, mschmidt@redhat.com, netdev@vger.kernel.org
References: <20231116144119.78769-1-ivecera@redhat.com>
In-Reply-To: <20231116144119.78769-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 16. 11. 23 15:41, Ivan Vecera wrote:
> The series simplifies handling of VSIs and VEBs by introducing for-each
> iterating macros, 'find' helper functions. Also removes the VEB
> recursion because the VEBs cannot have sub-VEBs according datasheet and
> fixes the support for floating VEBs.
> 
> The series content:
> Patch 1 - Uses existing helper function for find FDIR VSI instead of loop
> Patch 2 - Adds and uses macros to iterate VSI and VEB arrays
> Patch 3 - Adds 2 helper functions to find VSIs and VEBs by their SEID
> Patch 4 - Fixes broken support for floating VEBs
> Patch 5 - Removes VEB recursion and simplifies VEB handling
> 
> Changelog:
> v1->v2 - small correction in patch 4 description
>         - changed helper names in patch 3
> 
> Ivan Vecera (5):
>    i40e: Use existing helper to find flow director VSI
>    i40e: Introduce and use macros for iterating VSIs and VEBs
>    i40e: Add helpers to find VSI and VEB by SEID and use them
>    i40e: Fix broken support for floating VEBs
>    i40e: Remove VEB recursion
> 
>   drivers/net/ethernet/intel/i40e/i40e.h        |  91 ++-
>   drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
>   .../net/ethernet/intel/i40e/i40e_debugfs.c    |  97 ++-
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 563 ++++++++----------
>   4 files changed, 371 insertions(+), 390 deletions(-)
> 

Oops, wrong files submitted... Apologies, please forget about this (v2) 
series.

Ivan


