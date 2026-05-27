Return-Path: <netdev+bounces-292152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH9aIaWiFmqBnwcAu9opvQ
	(envelope-from <netdev+bounces-292152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:52:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CDE5E0A42
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F000300D559
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEAE3CF026;
	Wed, 27 May 2026 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WW3s/h7W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC983CDBA9
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868317; cv=none; b=AFohpxGRukXVgvxi9s/6Uqt2mLItQH8Dwe8n8rx9WjnkRNSe7yK3tkUdaj7yYzNhoh0GOwVdn9A4SSCYgL4le8b6R3c8vsFtGnhxiwuHRl36U2SUOLti1jFKjThqiXkhi881FukCTaeWdymbwUfldkXARPztSmEbnbF/C/BRKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868317; c=relaxed/simple;
	bh=BAe+EarAbMuIYW0DQUGD5Tt7lDM7vRg8HgwirF3AAvo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NbQbltEFbBTEcl6zdOB8A5+3PUOTc7NXYGfMTwlQr/QJq/C2cid2B71Px7NgxOvbQG7iYn6+qY0WNDFRxq5k/BCwkaS2M9OEphJ/YJhG+O3K6YTgSvPW1HTgUAWIWvM3i1G3vN6VPNn6jyyPEDqlyRgFWKhRkKbuddVmiX6n8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WW3s/h7W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779868315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s8MKYKkgpzAFLPjRo1YpVAV+ujkH8ODdIP3anGZt+es=;
	b=WW3s/h7WRPAq7c/qu6H9dkt3TGUgLmeHrQ+eOtu+EekTb+8J2wOxxOgeXaCEuM/f57Oav1
	3TAtKQ6PDHWxQ4+H7XG9BTpFyOPkEdA9cYv2G7WyHtTbVgkj+B4rN0/3DPD+LkxifEcM+c
	mMTsIZefEZQc0VUzE28HK6BZqqSkAIE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-nlhaX1s-P6-__aJGyDHRHA-1; Wed,
 27 May 2026 03:51:49 -0400
X-MC-Unique: nlhaX1s-P6-__aJGyDHRHA-1
X-Mimecast-MFC-AGG-ID: nlhaX1s-P6-__aJGyDHRHA_1779868308
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9820D18005B3;
	Wed, 27 May 2026 07:51:47 +0000 (UTC)
Received: from [10.44.48.151] (unknown [10.44.48.151])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A584719560A3;
	Wed, 27 May 2026 07:51:44 +0000 (UTC)
Message-ID: <d8226c8e-8821-45b4-9188-be81047ea6ba@redhat.com>
Date: Wed, 27 May 2026 09:51:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] dpll: zl3073x: use __dpll_device_change_ntf() and
 remove change_work
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Jakub Kicinski <kuba@kernel.org>, Petr Oros <poros@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20260526074525.1451008-1-ivecera@redhat.com>
 <20260526074525.1451008-3-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260526074525.1451008-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292152-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 85CDE5E0A42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 9:45 AM, Ivan Vecera wrote:
> The change_work was introduced to send device change notifications
> from DPLL device callbacks without deadlocking on dpll_lock, since
> the callbacks are already invoked under that lock. Now that
> __dpll_device_change_ntf() is exported for callers that already
> hold dpll_lock, use it directly and remove the change_work
> infrastructure entirely.
> 
> This eliminates a race condition where change_work could be
> re-scheduled after cancel_work_sync() during device teardown,
> potentially causing the handler to dereference a freed or NULL
> dpll_dev pointer.
> 
> Fixes: 9363b4837659 ("dpll: zl3073x: Allow to configure phase offset averaging factor")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Hi Kuba & Paolo,

patchwork reported netdev/build_allmodconfig_warn failure for this
patch. But it looks weird:

https://netdev-ctrl.bots.linux.dev/logs/build/1100767/14594344/build_allmodconfig_warn/stderr

I don't understand how this is related to this patch.

Thanks,
Ivan


