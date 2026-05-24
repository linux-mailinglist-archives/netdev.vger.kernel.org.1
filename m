Return-Path: <netdev+bounces-291201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIgCIHIfE2ra7wYAu9opvQ
	(envelope-from <netdev+bounces-291201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 17:55:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 871525C3029
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 17:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EABA3002910
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC9639B94A;
	Sun, 24 May 2026 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNt0IIsW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D224C6C
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779638097; cv=none; b=hkoa1YSwj3FUMBMVV4BWL56aWHNU6gkSWeU8cN9oTD2SeTxovwIy3zkPSe3Yzlv8vy6AIw1r597OeWXCS1oyt3SNZ1veaK+RUTHgJZErN/G9u03fTlvx6qPJVo0Pn/LZsroWmo7e/mVcYwN/tqg31WnIC/CmxNYxdfPI+90360s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779638097; c=relaxed/simple;
	bh=D0AR2DYmDZ44+BpsMu0aj8D62Qx6zvIU2M2G+Vz1iSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3OLOOLe9kGWjX30ylhPmcxMcCPrY2rVz+xI9Cxc9rdd9/e2zWoZqt09qTj/4p16pPrQmIZjZLZwae3NNoiex5WajyLwSnJJrsXA+VZTmwkGSO6/NTeayTkPDqWu4R44MwmrRxKD9t+AFxlhY5RjFLqzxE470xD5olAR1KI6WHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNt0IIsW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779638095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0AR2DYmDZ44+BpsMu0aj8D62Qx6zvIU2M2G+Vz1iSc=;
	b=KNt0IIsWo8aMvTAtDPy+HC1OE6vW4bdD3o7rQIVIJLAr89mCi9gG1RhuEQxJdVNU2K/m2d
	/b4xdCx83/SUV71NF2kPEY4FIj4v6LoKCfNZ+yh/PZhYl19Sabca5ZTveAPxgkSI6/2f8V
	Yr0Cawpe832ZXpvRp1GXoFHnIytXfkY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-G6XIhPvJMhCkk0ILct7bdw-1; Sun,
 24 May 2026 11:54:51 -0400
X-MC-Unique: G6XIhPvJMhCkk0ILct7bdw-1
X-Mimecast-MFC-AGG-ID: G6XIhPvJMhCkk0ILct7bdw_1779638089
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CED0180034E;
	Sun, 24 May 2026 15:54:49 +0000 (UTC)
Received: from [10.44.48.22] (unknown [10.44.48.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94BB81956053;
	Sun, 24 May 2026 15:54:44 +0000 (UTC)
Message-ID: <e928da41-90f1-4e7b-ac43-4440c3b91335@redhat.com>
Date: Sun, 24 May 2026 17:54:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] dpll: zl3073x: add NCO virtual input pin
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, poros@redhat.com, arkadiusz.kubalewski@intel.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 jiri@resnulli.us, mschmidt@redhat.com, pabeni@redhat.com,
 pvaanane@redhat.com, Prathosh.Satish@microchip.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org
References: <20260521074220.432590-3-ivecera@redhat.com>
 <20260523002742.1766902-1-kuba@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260523002742.1766902-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291201-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,intel.com,davemloft.net,gmail.com,google.com,resnulli.us,microchip.com,kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 871525C3029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuba,

On 5/23/26 2:27 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "I think the report / question about the SEM wasn't asked
> on v2?"

I see some potential locking issues besides Sashiko findings... I have
planned to include the locking change in zl3073x in PTP series but
IMHO it will be better to include it here.

Thanks,
Ivan


