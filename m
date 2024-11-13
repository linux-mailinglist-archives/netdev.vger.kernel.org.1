Return-Path: <netdev+bounces-144267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A120F9C66B9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C771F25711
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 01:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2793182D2;
	Wed, 13 Nov 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="WwX4yF1Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bupu9b5n"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BF29A5
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461505; cv=none; b=opo4W0pUnBZhkG5m8UjKd8BRW80Bj836OoTksFU+TwZucaEfUVGgv6UeT6WYaRTRW4r07VJP7LNfy2X52XiksimuEmbyDRcbYylXmRHAoA0/S9yCejYyCM1SyZ81DEDtcnMw8pO5WoMTGCIIo8eThfO9JHxDxswus2vB67IOQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461505; c=relaxed/simple;
	bh=W3Jy1sjo1rKWdNY8N4qE3UzTPrGOiqRUUIQ/T3/jKBE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P28P0Z8Sn/8vE8Bcv3cJPbRTmZT9vUg/OgvrWdnQqrcbxashD0InXpQtZMSRXGOJtEPhJS7tv2S1use4d2UHqk1EEFyDag+Jh/N/9LmMqCaZqo+sXlTEUqeitKXwZGUm39Qk8O/wuno6cZXFMtftq2HuOJoqjNJHwJqWmrEBU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=WwX4yF1Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bupu9b5n; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E7861140081;
	Tue, 12 Nov 2024 20:31:42 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Tue, 12 Nov 2024 20:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731461502;
	 x=1731547902; bh=iyIH6tkCp7zs8x47CvfHFO5X5AgmWhQjSf9eUwKoy00=; b=
	WwX4yF1ZfPytkvS3Cs90yomBYqO9N6BY9SRej8l4OeI9Xx1PWOld2zugcVJR/X0E
	A2Mt4UK3xLb9IOGapUo6UlStOgML7RkuC30ptFht8P/xzTuLsHiJpWu9ucEf1mu4
	UumzNmFcVsN5S7FZ+A4yo3gC3a3Ghpgrg4tATH3uEoGcZLzBH+EHRfBBSKBzSj/M
	rOiI/C5R9keaZz6A/la7ikpdapsA+fce0N19MI+fvjFOOITGmesSZ9S1oyqsC4nR
	DmhYWl/1DKyiT+d34UyPlSZg1AzT+bpm3FX5KE1m3pdZdzkBQ/S1++m3xRRv9nw+
	5op9k0jApJnEoLtd1hda3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731461502; x=
	1731547902; bh=iyIH6tkCp7zs8x47CvfHFO5X5AgmWhQjSf9eUwKoy00=; b=B
	upu9b5n5pgI0UCae5Qn+J+bty3o3DgqmKASS/CIN9iQKz2yr+5VSaPcIWfpDsFAj
	2N1EYH15jy+NAA19PW8XdOwyXYhYzDvWSUBbSi2OhztbFaAjaBIpiQ8HxS/mXalX
	VWrygMG/oHfaSufxBaPy0S4u9r4MwqL2XE5AnYbqNqpn/bGNWcfLPXcQcFAdVA0J
	fqcF8/PHwgRlSOFRUC+hgGcvxQ5QNrzDf6dXCtSAoNgRwdr3wJtAqiQzjI/z4U+D
	kXup5LSTASFz2hA6PDBZq/CbyHNyWuu+3E01NNhbsucCM8YPhlHwmibN7Izt/jgD
	nAyU0JRxrbup1tf/FAFzQ==
X-ME-Sender: <xms:fQE0Z_XH4Iyq7j8rmMBlMLSE5wmIhqzDlB2zgDVQnMNsZGt8wf5oug>
    <xme:fQE0Z3ldLQMYL0YwysbvQAgUMBnuAkMH4ekzMCa787-elT2ZXiUFXGnspa7_8JYQx
    vXQIN63JO06m0IRaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgeelieffhfduudeukefhieef
    gfffgeduleevjeefffeukefgtdelvddvfeefiedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehjuggrmhgrthhosehfrghsthhlhidr
    tghomhdprhgtphhtthhopegvtghrvggvrdigihhlihhngiesghhmrghilhdrtghomhdprh
    gtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhn
    rdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmh
    gvthgrrdgtohhmpdhrtghpthhtohepmhhkuhgsvggtvghksehsuhhsvgdrtgiipdhrtghp
    thhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fQE0Z7baNy0cAJqA6tviK_-Bw_o3xWKIGIVnwb8RmhVnvn35M-P1iw>
    <xmx:fQE0Z6UP8ycEwKEsIBNEh8fakAHdVCKpZfA19GkNETj9SdWPeaPsyg>
    <xmx:fQE0Z5mr6yA0piRRyDDCEKZumzRxDE0IlI5b-Pd8pEP_soEH84dXfw>
    <xmx:fQE0Z3cidiB5w1ec3cpVi5rybCQEGKg19VWFTUPMgRbs0rc8eezgGA>
    <xmx:fgE0Z_U3fdYpe31eA4qglVPX0Dq5S6XIGNKAsBCl9bChtnDHvvmkQBkS>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8691518A006B; Tue, 12 Nov 2024 20:31:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Nov 2024 17:31:20 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Edward Cree" <ecree.xilinx@gmail.com>, jdamato@fastly.com,
 "David Miller" <davem@davemloft.net>, mkubecek@suse.cz,
 "Martin KaFai Lau" <martin.lau@linux.dev>, netdev@vger.kernel.org,
 "Kernel Team" <kernel-team@meta.com>
Message-Id: <57047008-53c9-4744-b408-f78fef4c1871@app.fastmail.com>
In-Reply-To: <20241112074047.44490c6e@kernel.org>
References: 
 <978e1192c07e970b8944c2a729ae42bf97667a53.1731107871.git.dxu@dxuuu.xyz>
 <20241112074047.44490c6e@kernel.org>
Subject: Re: [PATCH ethtool-next v2] rxclass: Make output for RSS context action
 explicit
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jakub,

On Tue, Nov 12, 2024, at 7:40 AM, Jakub Kicinski wrote:
> On Mon, 11 Nov 2024 12:05:38 -0700 Daniel Xu wrote:
>> -	if (fsp->flow_type & FLOW_RSS)
>> -		fprintf(stdout, "\tRSS Context ID: %u\n", rss_context);
>> -
>>  	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
>>  		fprintf(stdout, "\tAction: Drop\n");
>>  	} else if (fsp->ring_cookie == RX_CLS_FLOW_WAKE) {
>>  		fprintf(stdout, "\tAction: Wake-on-LAN\n");
>> +	} else if (fsp->flow_type & FLOW_RSS) {
>> +		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
>> +
>> +		fprintf(stdout, "\tAction: Direct to RSS context id %u", rss_context);
>
> Do you have strong feelings about the change in formatting?
> Looking at Ed's comment on the new test made me wonder if the change 
> in capitalization is for the better.
>
> Action: Direct to RSS context id 1 (queue base offset: 2)
>
> vs
>
> Action: Direct to RSS Context ID: 1 (queue base offset: 2)
>
> Given "id" is a word (: I like the ID format, the extra colon is
> annoying but OTOH if we retain it your regexp in the other patch
> would match before and after..
>
> Actually the best formatting IMHO would be to skip the ID altogether:
>
> Action: Direct to RSS Context 1 (queue base offset: 2)

No strong opinions other than I agree second colon should be skipped.
Let's go with this one.

