Return-Path: <netdev+bounces-279868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN4xKdFU5mkDuwEAu9opvQ
	(envelope-from <netdev+bounces-279868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:31:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5688F42F919
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F07BC306D2F8
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE6A3431F2;
	Mon, 20 Apr 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IatpSvzN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2196233DEFE
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702291; cv=none; b=AsaeMhGOHzVO3xNmrfr1FZsqmpbZ51s0Q+EnevL40X8A6etperuJfBIqRf+c4qlu3xGWEW3yuKdfW+Tx0E5vn7JuxBeyPFYIxxLx15puQRbKD7IrBYBb7GMYhKU3IXoAU5g+2RBrjcSfLf7QiP7k4xoO+wTWOulOUs88MDZJyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702291; c=relaxed/simple;
	bh=SCUAHsTfk//sPwYyZpAY2IDbHPbtNBdBbxKcnzsf4LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaNSdsUg65rN795BepJPEI0So9b8mPVPcq0684Ad12e452W3DK02HyfVFPHOGGRZA66Uxj9qw0GQYLA2MxIugCd4JZbGjBxCs+MGYLK6B3IRN/yHX6o9DPyWI3uqlRlLit3YZbTHMFsVZTz/VycKLuCCpNz/nH68bCgYVHsFExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IatpSvzN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776702289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ONUEBsaSjlb643VNLT8SxeI2rJ7DFKrz+q+1kB/Dzw=;
	b=IatpSvzNhYbH24JNwFoMWcbPQfJNbtX03G0x9bOD/QDlWMlmYQ/7rtmTNHxKNM3JrgwYt4
	Zwf2+2Onw4Jsz5FARLD7gjWu121YDwOCgtQp5hQfgQUIFs5HtA089yHu6XhJrZIgpc7cYh
	5TZsW0DGcCmZbB+wpfMNqdlM3OzsQJg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-9VaBhAjGNZWvm9vTTJu7hw-1; Mon,
 20 Apr 2026 12:24:45 -0400
X-MC-Unique: 9VaBhAjGNZWvm9vTTJu7hw-1
X-Mimecast-MFC-AGG-ID: 9VaBhAjGNZWvm9vTTJu7hw_1776702283
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBF701944F0E;
	Mon, 20 Apr 2026 16:24:37 +0000 (UTC)
Received: from [10.44.32.172] (unknown [10.44.32.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56A0A1800351;
	Mon, 20 Apr 2026 16:24:35 +0000 (UTC)
Message-ID: <fda7883e-b502-44dc-97b3-af658a035d0b@redhat.com>
Date: Mon, 20 Apr 2026 18:24:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question/proposal for DPLL NCO (DCO) mode
To: Jiri Pirko <jiri@resnulli.us>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>
References: <21cce17b-9a79-41b5-8363-faee2378aa37@redhat.com>
 <3rgm35qzwvzdrubvtdrccl3sb5cx2ufiy7b5wnjun223bosi45@2bnbfrlqnsbk>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <3rgm35qzwvzdrubvtdrccl3sb5cx2ufiy7b5wnjun223bosi45@2bnbfrlqnsbk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279868-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5688F42F919
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/20/26 3:43 PM, Jiri Pirko wrote:
> Mon, Apr 20, 2026 at 01:42:29PM +0200, ivecera@redhat.com wrote:
>> Hi all,
>>
>> I am currently working on adding PTP clock support (PHC) to the ZL3073x
>> driver, and I would like to discuss an architectural addition to the
>> DPLL subsystem enum dpll_mode before sending the formal patch series.
>>
>> To support IEEE 1588 PTP, the hardware DPLL must be decoupled from
>> tracking physical reference pins. Instead, its output frequency needs to
>> be continuously steered by a software PTP stack (e.g., linuxptp) using
>> the .adjfine() callback. In the industry, this specific hardware state
>> is widely known as NCO (Numerically Controlled Oscillator) or DCO
>> (Digitally Controlled Oscillator) mode.
>>
>> Currently, the DPLL subsystem defines two modes in enum dpll_mode:
>>
>> MANUAL: The user explicitly selects a physical input pin to track.
>>
>> AUTOMATIC: The hardware automatically selects the best physical input pin
>> based on priorities.
>>
>> Neither of these accurately represents the NCO/DCO state, where physical
>> pins are ignored, and the loop is fully software-steered.
> 
> The manual/automatic mode is defining strategy/behaviour about how the
> input pins are selected.
> 
> <header_quote>
>   * enum dpll_mode - working modes a dpll can support, differentiates if and how
>   *   dpll selects one of its inputs to syntonize with it
> </header_quote>
> 
> You don't want to change the strategy. You just
> don't want that/don't care. Why it make sense to add a mode then?

It depends on the perspective. NCO is a selection strategy where the
DPLL does not lock onto an input reference (select nothing); instead,
its frequency is software-driven.

Btw. we’ve included DPLL_MODE_DETACHED in the documentation, which could
describe this use case.

But...

> I was thinking exposing this over STATUS. We have:
> UNLOCKED (free running)
> LOCKED
> LOCKED_HO_ACQ
> HOLDOVER
> 
> So something maybe like SW_STEERED? But:
> 
> The problem is you need to do selection. Perhaps we can have a
> "magic pin" to select for this :S ? We have pin of type
> DPLL_PIN_TYPE_INT_OSCILLATOR already. Perhaps we can have
> DPLL_PIN_TYPE_INT_NCO/NDO? It's a source.
> 
> Makes sense?

Yes, this makes sense from a selection standpoint, and I have to say I
like the idea. It also has an additional benefit: if we have an NCO pin
type, that pin's frequency can be used to configure the delta frequency
offset of the DPLL device itself.

I’ll proceed this way. Thanks for the advice!

Ivan


