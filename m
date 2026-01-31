Return-Path: <netdev+bounces-255469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCWZJ5A5fmn7WQIAu9opvQ
	(envelope-from <netdev+bounces-255469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:19:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A78DC32B6
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCE90301FCB7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 17:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8FB348445;
	Sat, 31 Jan 2026 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVY8nC1x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7C329C78
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879939; cv=none; b=VsG5i9M0hJdfa30f7m07d1HGKwgcFjIH9RPxIeXbULLHq2uDnHUKjkISa7Eop5PO8fz0cK7HGEfe0SJd3nuIRu4jx0Y2698rpZDrUOvJPCM3zIseCUBdQPfFj0I+5gFzuNag8nJwmMmq0M7O5zrfYD3Kh+trXND9UJGYkbVrlSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879939; c=relaxed/simple;
	bh=SRbpMgp//MlZoMroQOq3CCTxUaqu/v6YKoNy6fCQMoE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XRSn4QMof7PWycw2GlStl6EQcdJzgFeyWn87k8v4LDruI6Nc7zjYIP0oAdWXZUubhebCZkpTByLF9xDXaLzU3IBzIg9QJto+apdNXx0OZ+ga7i9swo9w9rZRzPWYYvl9FwEEyZPsk5KMOz1jbLmb2ByAU9HstbHwB1Xc57VEi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVY8nC1x; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-649655f14daso2911432d50.0
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 09:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769879937; x=1770484737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nf1H39GseXa0MaF9o3mhYXYnAWA6yd8MoMX3kBkjYXQ=;
        b=eVY8nC1xqm/DNSOrzzMhTrzIhfElUBvr9J37OkRa6RrmLJOZHOJ9PKgfeUzXV6kedI
         GubIHzkZgpy430Kf3Ph2gsvaVOCMrSZQUvQ+uzecHeM2ywz9WXiMHsMas8fMlV3krZ0T
         yu+EG1ySjNC1eE1nnYidKgd/5xZ6hjSQJSWvoAnbBlTF1m6IHHqDNFHl77oL6Zsa+rWx
         aNLRG6Z66gz85crgIYbUh/6u9srxbxESPe5Xz+2grzOwoOnhI1zpFbkpGCIqVn6o6SkD
         S3vwswfUNQAm1urkoGrnNn06HtrwdtCqbk5h5iWVIg7WhRFDcfdTPY5JqQUO+kEx+xof
         sRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769879937; x=1770484737;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nf1H39GseXa0MaF9o3mhYXYnAWA6yd8MoMX3kBkjYXQ=;
        b=ZopSXTWEWoH2POi9Wr9g3DjNlaclnnceOSJEG3qoc3IycqYPsA6KmzpGlz8yKUmHSE
         WzTCyReBwgu8swpsSZj/uzYBEPUUyvZtm9Rl5tyUCyUh560CUy0EQeCvBw27D15OROel
         +ZvuLIQJXjtjDjxN2tz56rWB+Gbgju75m1JPPIJALnQrLDqPa/67fczZFHS5Yb5PjxoR
         +uTXosKHeXEYMvESlkkFw3agHoQCg/MIs5zg0ki4tuW6ZHADAcKoIKEKgYHV+BYcMsAw
         lPcDS4vlbSfoFrVeH6tILwVU83lQtG3ZpQUs8J5pkRwoCHdIwqPVTj2/UHgxiJ8G+rLg
         1ZlQ==
X-Gm-Message-State: AOJu0Yw9CRJVnOEKOdug3b1DQ2ZuV/z/bnxd+8PNU+HCgorzhZqBbh3N
	5Y6WxLFv6AX/uUGzXR5nTNwmGl/wPE4tDhA02gEG/DFmyWGuabXwhlVV
X-Gm-Gg: AZuq6aKILp1/jeAbLAg4zciIz2y4C4HpyyNOXaFCl7+OlBG8GzzZE1lhWFFlKldTlth
	PaewvbWP6CNvVIe7lT9qL8dMrXTIBbu0BX3yThiClmwPaHxteKpo91W48ZvtMKZmxzoIhoN6Wg7
	GRxZUuvfjBuop7KepjTU5xg1lsI0z3pXJZTriY2LymLQs/1d2HqfC9DEbpr1Nnr+4IZb3VT0P4G
	yAsb6qF2UCYS7AJ4OX8KghnXHSyZJFp35WP9o4USPHAqsAxpxOkk7FkYA/sERHr8SnxSEF5CRnV
	1PThBLY30EOFLZx2Yn7XO/VgL/nqlNZ87tcSwtYJD36wMDYwzeA+bxpHZkl0GWmlOd8VLb82Qwh
	hr3arq+l/06GtL2Feoe321hKtunyDBRIhpK2jOp5U7JNqKzzohvHuafMXmucV0nMnO3Bi29nwHg
	oM11zP5jxi0rjYkhJiTjt9Vai7EW0scokx8Efin3m881kJ1STAbiQreheRXkw=
X-Received: by 2002:a05:690e:4106:b0:649:6a9b:9902 with SMTP id 956f58d0204a3-649a84e05bdmr4993542d50.65.1769879936963;
        Sat, 31 Jan 2026 09:18:56 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64996105c96sm5135603d50.23.2026.01.31.09.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 09:18:56 -0800 (PST)
Date: Sat, 31 Jan 2026 12:18:55 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.29ba7c9e89f32@gmail.com>
In-Reply-To: <20260130192912.826454-1-kuba@kernel.org>
References: <20260130192912.826454-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: rss: validate min RSS table
 size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255469-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A78DC32B6
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> Add a test which checks that the RSS table is at least 4x the max
> queue count supported by the device. The original RSS spec from
> Microsoft stated that the RSS indirection table should be 2 to 8
> times the CPU count, presumably assuming queue per CPU. If the
> CPU count is not a power of two, however, a power-of-2 table
> 2x larger than queue count results in a 33% traffic imbalance.
> Validate that the indirection table is at least 4x the queue
> count. This lowers the imbalance to 16% which empirically
> appears to be more acceptable to memcache-like workloads.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> +def _test_rss_indir_size(cfg, qcnt, context=0):
> +    """Test that indirection table size is at least 4x queue count."""
> +    ethtool(f"-L {cfg.ifname} combined {qcnt}")

Remind me: does this work with devices that advertise RX N TX N rather
than combined N?

> +
> +    rss = _get_rss(cfg, context=context)
> +    indir = rss['rss-indirection-table']
> +    ksft_ge(len(indir), 4 * qcnt, "Table smaller than 4x")
> +    return len(indir)
> +
> +
> +@ksft_variants([
> +    KsftNamedVariant("main", False),
> +    KsftNamedVariant("ctx", True),
> +])
> +def indir_size_4x(cfg, create_context):
> +    """
> +    Test that the indirection table has at least 4 entries per queue.
> +    Empirically network-heavy workloads like memcache suffer with the 33%
> +    imbalance of a 2x indirection table size.
> +    4x table translates to a 16% imbalance.
> +    """
> +    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> +    ch_max = channels.get('combined-max', 0)

Same here: not all drivers set this.

Perhaps we should skip if absent?

And does combined-max mean all queues across all contexts, or per
context? The test seems to imply the second. My intuition was the
first. Is it clearly defined across devices. per ethtool_channels,
seems per device?

  * @max_combined: Read only. Maximum number of combined channel the driver
  *      support. Set of queues RX, TX or other.


> +    qcnt = channels['combined-count']
> +
> +    if ch_max < 3:
> +        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
> +
> +    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
> +    ethtool(f"-L {cfg.ifname} combined 3")
> +
> +    ctx_id = _maybe_create_context(cfg, create_context)
> +
> +    indir_sz = _test_rss_indir_size(cfg, 3, context=ctx_id)
> +
> +    # Test with max queue count (max - 1 if max is a power of two)
> +    test_max = ch_max - 1 if _is_power_of_two(ch_max) else ch_max
> +    if test_max > 3 and indir_sz < test_max * 4:
> +        _test_rss_indir_size(cfg, test_max, context=ctx_id)
> +


