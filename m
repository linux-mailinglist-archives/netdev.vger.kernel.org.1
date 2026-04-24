Return-Path: <netdev+bounces-280957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEAXCiAc62l1IgAAu9opvQ
	(envelope-from <netdev+bounces-280957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 09:30:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CD445AB9E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 09:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4156A30022EB
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63773219A8A;
	Fri, 24 Apr 2026 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b="neV+C96F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRKZM8Jb"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2C214813
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015831; cv=none; b=O/FJ8tmnistfhCQA9A/600QVIiVqsDr4Qzr5QIgmEE2K6apQ/wlXxPH7EbpGyUkdzp2a3jyeFWZGbOlH5DQ2kyHREmWczsfTpO5fq8cdhZdScFFg1u8gdTxqceQhQ/lYYx28IcM2BTq/AshqP6STudawVInbrzwu0HSDWhIaAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015831; c=relaxed/simple;
	bh=uPjTOOcrhgiXiWqbSNaVZqPCn7yFv3qwrcJquU0CMVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMUtgnFwcfxBjhvL7GvpnhxZMB+bzzTtYKUELIpEIv9taYRx0ZzBc3heDSWSnZc87gW6SvgLrYkXIrpMADdkYWPTanHiyFgRTsIVqxxf+UFAwtwvza99Og4BZhxaEH6fY5cnZNGUFbmJd1NSt9bIh23+HGeR7ZH48leCzSrsEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au; spf=pass smtp.mailfrom=traverse.com.au; dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b=neV+C96F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRKZM8Jb; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=traverse.com.au
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5ED161D00065;
	Fri, 24 Apr 2026 03:30:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 24 Apr 2026 03:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1777015827; x=
	1777102227; bh=+jkHEIOF8G1HZGjgglJp2PHwetZBzGzh61pkwEMhr6g=; b=n
	eV+C96FhAxfhD6i/ihNqBXDZR2TOPEmooGj4hZLtWFb+JvT311znHv6oKGF0FYrm
	QLB05Ys+r6g06Xf5AdMO+XVAu1bW55KwvoowyrkBPtfsdEKgcIVv6+3lah5/9FuY
	+MBmZJmmcC+SYtXB+P8N5p6HBLxIM4kTDgacoYcqWJcmlCaGB3gu2tqeJZSHTKln
	+pnHL9Iq3x669y+LDJ91fuuvHLPYHIamZQoAtSrLp8Nr3bKIMMHvLX2spKRZXrVA
	12kgdu8xIgwLgOCNh1pwL49S9a81s0wxZGMlxwYH0IitLPXnQmGIrPeduYaNuXSD
	DkucN+tzz/cA2ClBmsADA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777015827; x=1777102227; bh=+
	jkHEIOF8G1HZGjgglJp2PHwetZBzGzh61pkwEMhr6g=; b=eRKZM8Jbf/uvdEsbU
	CA13FBss5kW/fcMXCBLQYBpg1A6O95MFSP8USDfIYwWa7oj/GqESr580K2n1Io0K
	sxwYQRLxVO02H7SNvfPy3PhYwTudt0AsSsHKoD7brcaOTgAxw5TaGs2bHXHgAeCX
	04Sa33Yf5tGm9x87EXVzcmtE0ikVXloN9l6iTgswcF4u1fxOv8+B9u07yyspSYFw
	sTdPU7ftjkJTSre+k5Mrliha/BgG0fI4kMui9FB5TGkuoJk0mjHX9TF1a3W90K/K
	IEKD4dfX19K8u8Ba0h7aVX7+IeZLhtrgf47qJlLtmBr7oWU9LkYgMQ64CwuMvuKS
	J8VcQ==
X-ME-Sender: <xms:EhzraQZPMKi4KgX5KdE8ved2msZTCs6NM3p8zTL46woJoVnSivtMeQ>
    <xme:EhzraacEgp9F5_VtAcjEshmOKOVeCeYmNHP7BmllsSAR2ke3ABiqdX2ajDjFoGg4W
    XC87spE236FDRS-56nAnwN2revzKALiJpntqxRrX_LSDqhYBXZEIB0>
X-ME-Received: <xmr:EhzraRLDCmoGJls3YB28XRIVSN-UvI5HVf7z_st8AEsnYAAI2PgHIuMe_E0jGNkGy-vjAEIEQLw0hx8qw2ByFZpQbufC4b6YKpR_tOEGLUAjIoZjYph9yXhnAgXXVb8FzIDPOIsmiot0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepofgrthhhvgifucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgv
    rhhsvgdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeeiieefheeiieeuledufefgtd
    evfeejffetgedvveduffffleehjedtjeegleelgeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghtthesthhrrghvvghrshgvrdgtohhmrd
    gruhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegufihmfidvsehinhhfrhgruggvrggurdho
    rhhgpdhrtghpthhtohepohhpvghnfihrthdquggvvhgvlheslhhishhtshdrohhpvghnfi
    hrthdrohhrghdprhgtphhtthhopehguhihsehtrhgrvhgvrhhsvgdrtghomhdrrghupdhr
    tghpthhtohepphhhihhlihhpphgpshhusgigsehrvggufhhishhhqdhsohhluhhtihhonh
    hsrdgtohhmpdhrtghpthhtohepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghu
X-ME-Proxy: <xmx:EhzraXJYWLdtoVNsd_JTDmVfUrJtjRlcsdUMWG3hIn514oHNBC_skw>
    <xmx:EhzraQWjav0KecBNMtWMZEwjK9yrhJ_s3kEGK7lMg1KI9SJr9T_rZQ>
    <xmx:EhzraQnlMTTdrr4mX1ASL5DkzP9J1uhDmrRHBZwFfOzXlDAYWgxDJQ>
    <xmx:EhzraWnrE4IR6gBQYdwcGTz_pUfBv3xX0uOLBuv6k5H2iQHsfINghQ>
    <xmx:Exzrabc_-A5his2zZki5zNAf7jPFooRDStz-L8tLSMhvPkQMZZDXrH7X>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 03:30:23 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	dwmw2@infradead.org,
	openwrt-devel@lists.openwrt.org,
	guy@traverse.com.au,
	philipp_subx@redfish-solutions.com,
	Mathew McBride <matt@traverse.com.au>
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and legacy ATM device drivers
Date: Fri, 24 Apr 2026 17:27:05 +1000
Message-ID: <20260424072703.1338200-3-matt@traverse.com.au>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260422041846.2035118-1-kuba@kernel.org>
References: <20260422041846.2035118-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8CD445AB9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[traverse.com.au:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[traverse.com.au:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-280957-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[traverse.com.au];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@traverse.com.au,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.232.135.74:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[traverse.com.au:email,traverse.com.au:dkim,traverse.com.au:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, Apr 22, 2026, at 2:18 PM, Jakub Kicinski wrote:
> Remove the ATM protocol modules and PCI/SBUS ATM device drivers
> that are no longer in active use.
> 
> 
> - solos-pci - Traverse Technologies ADSL2+ PCI

Acked-by: Mathew McBride <matt@traverse.com.au> 

We (Traverse) have not made any devices with solos-pci for over 10 years now, 
and I assume (based on recent removal trends) that the Geode LX SoC on the 
last board that had it (Geos) won't be operable with new kernels for much longer 
(IIRC it's feature set isn't quite i586 or i686 level).

I appreciate the folks reaching out about this, however I can
confirm that we are not in a position to provide any further
support for solos-pci devices.


