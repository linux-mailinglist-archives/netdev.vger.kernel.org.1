Return-Path: <netdev+bounces-289791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGi5L3ZbDWolwgUAu9opvQ
	(envelope-from <netdev+bounces-289791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:57:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9295888D6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 905D73071DAD
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED044364E80;
	Wed, 20 May 2026 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/ANz9aC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2C3630B9
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259728; cv=none; b=QthVG1NiyKnYeBBrtbxQD5XwaaxqLaOFe17YmCImbD5sbL/BRWSSAmewNvU6ahqkdxfoI53gk62wE4VPWAd0/b1VrfJHirICYSsWPXdoJbTftCMM2oAuMrVxOq1tPSRCqscpw7kMGNKETLPUvS4bFn/0jrrLvSZHrNm7DBqiQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259728; c=relaxed/simple;
	bh=ZYpmqab6WhoOzXOcx2EvyFXWFf5IPGpglQK/hyx+H68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh7++nCSo7UGMdexESzhbyQmtlfSrv55PRiRbAv+aVKfeNRLf+uGQIvZFFGFiz/Jn6vXbBb0yhdEhwHHcoB5ZPvZZ57lVaCqRmhfamzgIy3vCwC35SVe0KUsNs0VSm2MzpvLRJB8iB54KdrvWWkk6TUTarYmemHn6Arxk2/tLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/ANz9aC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779259725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xauAd+4aqIgMuLm7Tiw+VX/5LeN56B9EH9yKQTJwiMs=;
	b=E/ANz9aCLQnrh03TTIu2w3lsaNDiqe0grXht5Iw8rr0VyPEVB4hjglGDS9Qeil0tL+p5vI
	c5RAnj8vno2XMH8B3VSTGC6+JLvORA/MHNkjpRMurZwIcDpKnuvSQQByxGYf7xSeWQmY0w
	HUryo8P/au0xc+xIA7CltrmQgRiNJU4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-LJj5Jf5XMc2mR1gXmGPGZg-1; Wed,
 20 May 2026 02:48:42 -0400
X-MC-Unique: LJj5Jf5XMc2mR1gXmGPGZg-1
X-Mimecast-MFC-AGG-ID: LJj5Jf5XMc2mR1gXmGPGZg_1779259721
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 737DD18002E3;
	Wed, 20 May 2026 06:48:40 +0000 (UTC)
Received: from [10.44.32.79] (unknown [10.44.32.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CB7B18004A3;
	Wed, 20 May 2026 06:48:38 +0000 (UTC)
Message-ID: <b2ef0af0-a140-475a-86e0-f32b1b240a6b@redhat.com>
Date: Wed, 20 May 2026 08:48:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dpll: zl3073x: Use named initializers for struct
 i2c_device_id
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260519142710.1587324-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260519142710.1587324-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289791-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1F9295888D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 4:27 PM, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

LGTM...

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


