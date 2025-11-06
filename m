Return-Path: <netdev+bounces-236177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F6DC395F5
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 08:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C0A934F0C1
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AF221D00A;
	Thu,  6 Nov 2025 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrR14myC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A167FBA2
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413590; cv=none; b=QCo9eIjWlGa6SKg67nSTfSLcV7B0Z8l84GwSZgPQTFsqVV49H3buLfpyE1wu5jOE9k6LfM+o8VMYBEqxCHIphqadRB53jAfngV0dFCEnAMp1gnSLTWfF+eJ+TP54yHj3d4MJeb9F75B9nldj46pkNAMsAy6hSCCPBuU8yAwIzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413590; c=relaxed/simple;
	bh=0/K4lq0iHDt8c7W6okrh/gsZLEHLj5w6TOEMSXqs2r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLEn1jJZQuIF+koNkOTCSP0tByN0MqrMGLfyjwfOz06N3fb16BwKcja9fEtUcJFMirOtic741dmMgfXeyFeOBaLsT2NC16k2tKK+H+JvomnGHIXQdtkNmfxeHxjJm/Xup5NlkWrTFuiXkM2UkiTQ+X4ULZ8UPneAO7q3QPAxWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrR14myC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762413588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JO5w+ZZkBjWjSUv4eXSST4Yp4WaHgr8+VnkKfKxnH7U=;
	b=hrR14myCYNQfkbfpuNYcJrtcd0lwioWmPHkHUj5yIzMzdbVgUCQfnDQVPjbdB+xB193ZBN
	dbYwA9D78V81y3VcMCcFvaNq2VYWGTtniwPGx4YCdbkZ+Lj0cXMYDArf+PWxtCRQwhEbNK
	GNU2LZTw4j3HHYLyGER9+j8bq6QzroY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-hr7QTN3sO_O-ODv9grSqmA-1; Thu,
 06 Nov 2025 02:19:45 -0500
X-MC-Unique: hr7QTN3sO_O-ODv9grSqmA-1
X-Mimecast-MFC-AGG-ID: hr7QTN3sO_O-ODv9grSqmA_1762413584
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FDB9195606B;
	Thu,  6 Nov 2025 07:19:44 +0000 (UTC)
Received: from [10.44.32.188] (unknown [10.44.32.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEA72180049F;
	Thu,  6 Nov 2025 07:19:42 +0000 (UTC)
Message-ID: <74b77b89-4359-4955-8560-f4284fbb03f1@redhat.com>
Date: Thu, 6 Nov 2025 08:19:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] dpll: Add dpll command
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, stephen@networkplumber.org, jiri@resnulli.us
References: <20251105190939.1067902-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20251105190939.1067902-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/5/25 8:09 PM, Petr Oros wrote:
> Add a new userspace tool for managing and monitoring DPLL devices via the
> Linux kernel DPLL subsystem. The tool uses libmnl for netlink communication
> and provides a complete interface for device and pin configuration.
> 
> The tool supports:
> 
> - Device management: enumerate devices, query capabilities (lock status,
>    temperature, supported modes, clock quality levels), configure phase-offset
>    monitoring and averaging
> 
> - Pin management: enumerate pins with hierarchical relationships, configure
>    frequencies (including esync), phase adjustments, priorities, states, and
>    directions
> 
> - Complex topologies: handle parent-device and parent-pin relationships,
>    reference synchronization tracking, multi-attribute queries (frequency
>    ranges, capabilities)
> 
> - ID resolution: query device/pin IDs by various attributes (module-name,
>    clock-id, board-label, type)
> 
> - Monitoring: real-time display of device and pin state changes via netlink
>    multicast notifications
> 
> - Output formats: both human-readable and JSON output (with pretty-print
>    support)
> 
> The tool belongs in iproute2 as DPLL devices are tightly integrated with
> network interfaces - modern NICs provide hardware clock synchronization
> support. The DPLL subsystem uses the same netlink infrastructure as other
> networking subsystems, and the tool follows established iproute2 patterns
> for command structure, output formatting, and error handling.
> 
> Example usage:
> 
>    # dpll device show
>    # dpll device id-get module-name ice
>    # dpll device set id 0 phase-offset-monitor enable
>    # dpll pin show
>    # dpll pin set id 0 frequency 10000000
>    # dpll pin set id 13 parent-device 0 state connected prio 10
>    # dpll pin set id 0 reference-sync 1 state connected
>    # dpll monitor
>    # dpll -j -p device show
> 
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Petr Oros <poros@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Petr, could you please add corresponding entry to MAINTAINERS file?

Thanks,
Ivan


