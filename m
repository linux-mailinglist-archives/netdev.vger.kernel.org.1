Return-Path: <netdev+bounces-300042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zD0ZAY88MmrqxAUAu9opvQ
	(envelope-from <netdev+bounces-300042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:19:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5557A696CF1
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:19:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=h6qu521a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300042-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300042-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B5B7307D7D7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8183B47C9;
	Wed, 17 Jun 2026 06:19:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB73B42E9
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:19:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781677189; cv=none; b=iXJEGOKvgHT76XawDRP5NCaEecXNmAOo91kyG0z6d/iOB8eO3TxjvYCliDBfTdMh187gGtGeXqMeTEvCyhHQGkjIfeVFk8Tala+3s0TCQOtbAI+QBtcKbCQbLw0OKbg1i39CDcrdbqUpjmyHnI/U3edgRZXjGudOtfQJpCJOLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781677189; c=relaxed/simple;
	bh=BgQYrmR+7GcniQAhoX3so0VbrDhC8RCJSeENc8FMxMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaRsQL/O1axxn03vwg0wr9yvI9AoUzkc5LrpJPss0fYvBtRKiqnnGKsFPN5WZCBds1ygXE6XA+yJa8binjcTAPbIkMir1irQTdPB21awiq+zLf0fCszxDEQpyyotZvu5J+avf5pPjvOOnJxI8fXLUeUYGJj+/NWkT/Nh5TeRzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6qu521a; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781677182; x=1813213182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BgQYrmR+7GcniQAhoX3so0VbrDhC8RCJSeENc8FMxMA=;
  b=h6qu521ad3b/FpfW0x8BQWzziSnE7v0kdTnNreCXeupHe0ezP8xFuK+n
   ztR+9PLIfx3r/Ite0FbDSzdJHVTf116rxnHpZAx6d3U83yJ4Xnwhf0caf
   1M7jx5pftqW7arHs2hTjdi74CnaPex0Pe6MdWdOQIb6xxS/TRlhxCAn0s
   lbO2VmlqDa6qIBY2rlPv5iz6wIXQidv10w2//oQr3WWHjDKt/6RAGKSK+
   pA2Tv4j3PbJLTzwI70PWtpDZkBUFZAQrxrx2/V4ZA0WuWP104KlPdVKaq
   cxpd+q06TgxVvMeHIynKPfAaSIFGigoLXsylTP6LG23a4htGhlVTYHH9H
   Q==;
X-CSE-ConnectionGUID: JYKdMwijQUWFA+TxnVLhKg==
X-CSE-MsgGUID: efuRD+3xT/+7zFrpd6Zzwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82471805"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82471805"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:19:41 -0700
X-CSE-ConnectionGUID: TcktqaFDSh+9s/CfjFS3Sw==
X-CSE-MsgGUID: 3T/LFQhuQICRo8MgbNZDTA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:19:37 -0700
Date: Wed, 17 Jun 2026 08:19:35 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
	kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	dev@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com, mallesh.koujalagi@intel.com
Subject: Re: [PATCH v3 1/4] drm/ras: Introduce error threshold
Message-ID: <ajI8d4FlRH_CtyZV@black.igk.intel.com>
References: <20260604184849.1011985-1-raag.jadav@intel.com>
 <20260604184849.1011985-2-raag.jadav@intel.com>
 <57e1f3a9-14b7-4bec-8765-deb70fe6b636@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e1f3a9-14b7-4bec-8765-deb70fe6b636@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300042-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:riana.tauro@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5557A696CF1

On Mon, Jun 15, 2026 at 02:26:05PM +0530, Tauro, Riana wrote:
> On 05-06-2026 00:16, Raag Jadav wrote:
> > Add get-error-threshold and set-error-threshold command support which
> > allows querying/setting error threshold of the counter. Threshold in RAS
> > context means the number of errors the hardware is expected to accumulate
> > before it raises them to software. This is to have a fine grained control
> > over error notifications that are raised by the hardware.

...

> > + *     + The driver can optionally implement query_error_threshold() and
> > + *       set_error_threshold() callbacks to facilitate getting/setting error
> > + *       threshold of the counter. Threshold in RAS context means the number of
> > + *       errors the hardware is expected to accumulate before it raises them to
> > + *       software. This is to have a fine grained control over error notifications
> > + *       that are raised by the hardware.
> > + *     + The driver is responsible for error threshold bounds checking.
> 
> Can the threshold be set to 0? What should the behaviour be?

Some may want it to be invalid while some may want it to act as a "disable
notifications" toggle. So it's upto the drivers and their usecases, not for
us to decide. Will add this.

Raag

