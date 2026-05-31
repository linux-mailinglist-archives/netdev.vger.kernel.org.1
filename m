Return-Path: <netdev+bounces-293483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHWkKlC5HGozRwkAu9opvQ
	(envelope-from <netdev+bounces-293483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 00:42:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9C618264
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 00:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78B29301106B
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 22:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FEC35F192;
	Sun, 31 May 2026 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="PW+IAv52"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E935E944
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780267315; cv=none; b=QjVDkAAExMH1QmBm+wGbCbFioQwrRppCfEinx/u2nHNEvIzieWzctJA/eYFvee18SNkn9Yvq/GCfxiH5NNPbTGQohuibvRPkRUERUA4hwQrMDw9TiCqSDfdtnQMhklHy2A3jSIqeR5eljNC9FZaEjkANTb2/F56GX+WIn7jIQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780267315; c=relaxed/simple;
	bh=QYnP5eG1tsJaWRPfgP1WwNKfVi/7N4S9D05dPrpFu1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFDFX70W+Oi/v34uxr8K5B/bNRtw7t7krzsw4mxbuCpo1ebJRCwhnB0i3Uo5Y79lyJhGCGNxS24uQVKVEyUYSGktYe7uKpni2m2eXcrrCRWMpgYxHj7OK2R2bAsQ1MTdAjeEqZII8PSzBgmvmAlnp5+GxQ2ti8Z0vU0gmIPyLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=PW+IAv52; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137335bc3caso7453142c88.0
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780267313; x=1780872113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/F3JV2QPDvY67PvZV1sf9gS7c+wroSrNdCqXiiKM2s=;
        b=PW+IAv521AmHcd7LhBG5XGqbac/qHz1xsfLkm/X+D0V/SyBW9pDHia9BlmMOxcWrwK
         KGUBL0kzrFVxlSk3ilrNyGB66FUrjw1PLt07qBhdd79JGJ/lNYbiGejV/fp0/erxLOTQ
         T0ywusxqmj37Ti5mdVg4dk34Dh/cbZgqP7UZl6ec4Z0SxsGuPsU4MZJyEJ3fr/m69h01
         ipUBIbJBXqrF0MKwitXBeV3BsfVT0kogdLD6joSJQyJ5I1OG0ilrRWqSQU2bTjKkby/j
         ZoW0Of/+TUnhVeabRCsznj3GgvAGZ+yIERpXVBW3g3Qr6xBV3V1uTxmMBdRhVyRNsdAC
         o/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780267313; x=1780872113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p/F3JV2QPDvY67PvZV1sf9gS7c+wroSrNdCqXiiKM2s=;
        b=S012YmYLh7ZZJU2LO9RtnM3HPfH8z17JaCtI4xMwdliWUMAoOsRGaZDYec9YXXU6TD
         OSfVdypJeKTjCOt2AZOxcEA4AwN5qSKdjNHUPFVi2+cJzfFGT2/4/oAfBtBHsPq6otZY
         YrB5CXfdlpAaLkB/zjSOEHz7RImush/GmO3l9iKuKBw79rSW54am53QIWWOtzg0dTLaq
         NUcbW6YA+detMml6/dGct7HL5e2oqZNlsctZ9sLnpYBXVKOLzymMwDZq5Bl8wYNUXKUz
         94pByvb6AVsDt9TwE8tFDoCm/OwFcwWzhZ2CX6EbDVBFTH0i3kYYxKu3sVmC2dbrt2YH
         dU0Q==
X-Gm-Message-State: AOJu0Yz2TeWHPOS+C6ROg5gYnEfKoOJeltOYX3R0+1aAE8Ic2dcAqnVd
	TAxsUKijslqDjSwze6eCnqPIkq+zzA8BOMobziP8FeWk4raipQ69D6PdR9rBTO6Fri8=
X-Gm-Gg: Acq92OGWVlfDVqcWNpFYjIphlIDJPgMkOMQgo7R6IklH/xsQTtKoSgIKLC7QYy6kLcE
	388/QSouqpncTHc+fZOC8t9GO2X3ksv5jD/m9hSskmxdS8q8AhdOqptf00lR5QMJTw20Z7Yx9v5
	78mcRmZ5sdOXHkebALmy83OC+pbF40an5V6C0WA9euB0p0Q3dWKomrJXZsN1Z9s78MdqD65dXeO
	eTg+KYKH5B+jM1ViUg4Bv99pvnlhkMEhUz9KDhkHnCIvMh6VVEe8ihjLhn2FFtdQ5LN4UQhecoz
	96hlQAHne8MoDQy22qZnM6RGjEczXSr5TpIjkm7EjUFG5acqODQkOrieDHbtSX5v54RzWan7EGz
	gkewWq/hiKUWXwAAp453bHuYD7I2gSt9qDeVXsJjLtIEruHf02qNW49hKnys8EHDrs16Ns0+VcD
	PcXc+V9Hhk1QmwnBoiZSll1jMyBjGMudd3D5v2AMjmKaqAjMbx+DvBZsJz2ypj90yZjb/+XkKWE
	MuyhmgpttBoiA==
X-Received: by 2002:a05:7300:cb13:b0:304:819f:5029 with SMTP id 5a478bee46e88-304fa4b7178mr3536043eec.2.1780267313031;
        Sun, 31 May 2026 15:41:53 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c120csm7497534eec.4.2026.05.31.15.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 15:41:52 -0700 (PDT)
Date: Sun, 31 May 2026 15:41:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Hemendra M. Naik" <hemendranaik@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 jhs@mojatatu.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, vishy0777@gmail.com, tahiliani@nitk.edu.in
Subject: Re: [PATCH net-next 1/2] net/sched: sch_fq_pie: add per-flow
 statistics via class ops
Message-ID: <20260531154149.592bb35f@phoenix.local>
In-Reply-To: <20260531125314.22492-2-hemendranaik@gmail.com>
References: <20260531125314.22492-1-hemendranaik@gmail.com>
	<20260531125314.22492-2-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293483-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,nitk.edu.in];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3BE9C618264
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 31 May 2026 18:23:13 +0530
"Hemendra M. Naik" <hemendranaik@gmail.com> wrote:

> +struct tc_fq_pie_xstats {
> +	__u32	type;
> +	union {
> +		struct tc_fq_pie_qd_stats qdisc_stats;
> +		struct tc_fq_pie_cl_stats class_stats;
> +	};
> +};

Sorry, you can't change the kernel/userspace ABI like this.
How will old iproute2 hand new kernel and vice/versa.

The better safer way to do this is to either extend the
existing structure and have iproute2 know how how to handle
short (missing) class data; or use another netlink
type for class data.

