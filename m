Return-Path: <netdev+bounces-279724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBjgFjIR5mlrrAEAu9opvQ
	(envelope-from <netdev+bounces-279724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:42:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A142A002
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E5243036EF2
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7D839C624;
	Mon, 20 Apr 2026 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoqUTKeA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9839902C
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685360; cv=none; b=o9ORmhMmAJlZnHi26HnyTjALyFx2jTBV24erOvlyok+I3sfJmABggLazEs5sqlVGK6UbonnTIUEp/+upSpMXxyoKjGwS0ppXusEQhvJbwmEhfvWFkC4sD6r5WAXWEtqT3XpaLC4xiYva3fQ9dqlxjmYM1AyC1GixoKKvcdMXN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685360; c=relaxed/simple;
	bh=qD7llhliang/WWMwH2RxsVHdNNjHRFaoiFtND2ndkUA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SSxw0DHtT6rSEI0t2mEDX3RrEAuOin9gIAirxvNDJXevK7M4k25dH0UAj8kruCA+0Kx5OKv+dtPh0UFJ05yZrfDFcRk0K0Qe/AvHMq0qerjIKctGyAhrD05Tk3uV1I63Qap1KL2D6RLN9xhPaIuvpi1iSbvcB184cKx2CkzuBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GoqUTKeA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776685357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yUGe+Th3tPju4gLZdI3HGFjT/z1fYCyqz1FtwlSb/eM=;
	b=GoqUTKeA8jSLoJUuPuL2oGDB/uIdIUuXeZwW+5z8UaqosmHeyAayKYxYv6RGnjD1NQgOJZ
	SaPXQFR+Tero4zF2ostIWBOtHaTZw+heJ65UisToGEyi2huDYI6UABleyekciIbY3EXU7D
	btxFDgSHWdBn+dhW/VMIq9VCwSfOdOQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-0hH9wgEHOJeBgYY4tQiTrA-1; Mon,
 20 Apr 2026 07:42:34 -0400
X-MC-Unique: 0hH9wgEHOJeBgYY4tQiTrA-1
X-Mimecast-MFC-AGG-ID: 0hH9wgEHOJeBgYY4tQiTrA_1776685353
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1D831800345;
	Mon, 20 Apr 2026 11:42:32 +0000 (UTC)
Received: from [10.44.33.204] (unknown [10.44.33.204])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BECA3000C15;
	Mon, 20 Apr 2026 11:42:30 +0000 (UTC)
Message-ID: <21cce17b-9a79-41b5-8363-faee2378aa37@redhat.com>
Date: Mon, 20 Apr 2026 13:42:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jiri@resnulli.us>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
Subject: Question/proposal for DPLL NCO (DCO) mode
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279724-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B28A142A002
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

I am currently working on adding PTP clock support (PHC) to the ZL3073x
driver, and I would like to discuss an architectural addition to the
DPLL subsystem enum dpll_mode before sending the formal patch series.

To support IEEE 1588 PTP, the hardware DPLL must be decoupled from
tracking physical reference pins. Instead, its output frequency needs to
be continuously steered by a software PTP stack (e.g., linuxptp) using
the .adjfine() callback. In the industry, this specific hardware state
is widely known as NCO (Numerically Controlled Oscillator) or DCO
(Digitally Controlled Oscillator) mode.

Currently, the DPLL subsystem defines two modes in enum dpll_mode:

MANUAL: The user explicitly selects a physical input pin to track.

AUTOMATIC: The hardware automatically selects the best physical input 
pin based on priorities.

Neither of these accurately represents the NCO/DCO state, where physical
pins are ignored, and the loop is fully software-steered.

Without a dedicated mode, drivers are forced into "automagic"
workarounds. A driver might implicitly switch the hardware to NCO mode
in the background as soon as .adjfine() is called, while misreporting
its mode as MANUAL to the DPLL subsystem.

I strongly believe this hidden "automagic" behavior is a bad design. The
user-space should have full visibility and explicit control over what
the DPLL state machine is actually doing.

The Proposal:
I would like to propose adding a new mode: DPLL_MODE_NCO (or
DPLL_MODE_DCO, I am open to suggestions regarding the terminology).

The expected workflow would be explicit:
If a user wants to actively steer the DPLL frequency via software (for
PTP or other Time-over-Packet applications), they must explicitly set
the DPLL device to this mode via Netlink first. Only then will the
hardware accept frequency adjustments via .adjfine().

I would appreciate any feedback from the DPLL subsystem maintainers and
the community on this approach.

Thanks,
Ivan


