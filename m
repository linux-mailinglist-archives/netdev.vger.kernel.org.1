Return-Path: <netdev+bounces-269270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCSJGM9gu2lujQIAu9opvQ
	(envelope-from <netdev+bounces-269270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:34:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702B2C5047
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 005B63019817
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59AB36897B;
	Thu, 19 Mar 2026 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv6KsHCA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEB2C21FE;
	Thu, 19 Mar 2026 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887689; cv=none; b=Nls2EHPmRJMsAdZz+flxe+eQRWVb1COly1tGZhmshwjEI9QmrKOdyo0qmjxBAHlWGIFJeO4fdaf/Z8zI8HbIb/gqt/Qbfqf6AMg6qsylIUx6h401y6sa/xy4gyG5e7XyzS06gdltpPXJB765H73CEtEXoruSEH5yHq5jpNVj5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887689; c=relaxed/simple;
	bh=eegzmj5P+BS9SL9Y6oV95qoVHEvqSEWfZ+k8aCJ4XMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehzc+kZTElwHl3MX8S9g91Rep94Tnh5bR/gRWPe1mbtWv5bwi3FJyrLOlWOjxYsqH1ppnzk8hE+/TPR0pzNlJJWPp9PbeqICqtWL9MUpGn+XsQkLtBc82jNb91QbVMt8d8bTjNBaaukkqW7HWpLdWBqi88eiVraP4MYGMg6chsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv6KsHCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F2BC19421;
	Thu, 19 Mar 2026 02:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773887689;
	bh=eegzmj5P+BS9SL9Y6oV95qoVHEvqSEWfZ+k8aCJ4XMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sv6KsHCAZxiCykt4d3twmtjE2v7S7mafinYXRJ3Sq43m/tRoNEu2rbjmCTJynSQT6
	 dbjjJldsPypq/YEzk3+p4X6hQJjdTuGC0t5KgDBDQpzapEyn3sMnMaz1XwXBBVcs3Z
	 qBq78WrCg+KyEaWx8Kl1+girzxBn41WUpqW4KCkDxJXgle/UZOCnRDYwWnDWm9LwwD
	 3vkPsVknrp/U+UTV5vaHgbRCGT4ilEnnkKf8f7/LotM68dadTY9zjdwyh7/IUsgLeA
	 ZySnxXekG3wn/gthdoKL5s0j431Rhu7InrXy8Ig+BrFmkM2/RtGqcnQeWzz42YbdPi
	 TOaJmCOXB0fAg==
Date: Wed, 18 Mar 2026 19:34:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Phani R Burra
 <phani.r.burra@intel.com>, larysa.zaremba@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 sridhar.samudrala@intel.com, anjali.singhai@intel.com,
 michal.swiatkowski@linux.intel.com, maciej.fijalkowski@intel.com,
 emil.s.tantilov@intel.com, madhu.chittim@intel.com, joshua.a.hay@intel.com,
 jacob.e.keller@intel.com, jayaprakash.shanmugam@intel.com,
 natalia.wochtman@intel.com, jiri@resnulli.us, horms@kernel.org,
 corbet@lwn.net, richardcochran@gmail.com, linux-doc@vger.kernel.org,
 Bharath R <bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next 06/15] libie: add bookkeeping support for
 control queue messages
Message-ID: <20260318193447.2e7b1f4d@kernel.org>
In-Reply-To: <20260317230905.847744-7-anthony.l.nguyen@intel.com>
References: <20260317230905.847744-1-anthony.l.nguyen@intel.com>
	<20260317230905.847744-7-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269270-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	NEURAL_HAM(-0.00)[-0.953];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1702B2C5047
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 16:08:54 -0700 Tony Nguyen wrote:
> From: Phani R Burra <phani.r.burra@intel.com>
> 
> All send control queue messages are allocated/freed in libie itself and
> tracked with the unique transaction (Xn) ids until they receive response or
> time out. Responses can be received out of order, therefore transactions
> are stored in an array and tracked though a bitmap.
> 
> Pre-allocated DMA memory is used where possible. It reduces the driver
> overhead in handling memory allocation/free and message timeouts.

Warning: include/linux/intel/libie/controlq.h:397 struct member 'force' not described in 'libie_ctlq_xn_clean_params'

Please also look thru the AI reviews before you repost:
https://netdev-ai.bots.linux.dev/ai-review.html?id=2078570c-9d93-4076-ace9-f275d8637314
and:
https://sashiko.dev/#/patchset/20260317230905.847744-1-anthony.l.nguyen%40intel.com

