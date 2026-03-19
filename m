Return-Path: <netdev+bounces-269455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM6XFEMGvGmurAIAu9opvQ
	(envelope-from <netdev+bounces-269455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:20:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B592CCA19
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2642F32B226D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46F331328B;
	Thu, 19 Mar 2026 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S96EPfOC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iu7yQySe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49539313E07
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929670; cv=none; b=lQyUiV49PWM0oMtCfUHlNctnwiD36qvn7+R66j7VWSnuLe+jQ+HLHXfi3v+dXWPzUX03t0tbS9vGxxpit5RtBdXeVnnFNIsTRLdTmBILmzXOmKPQtnmuMUD7UhWrUh9z8wi1EJD6VAQ1BEztrdP+YgRqMgj9H9Wa6jdq++eFqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929670; c=relaxed/simple;
	bh=mpGYkuoFur83l6peicrslGmVrZid01nUXuHUka+y71s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+4nzu7JgLKlZWjcD9viG9Cn1kBkjQALYJIXtJLoJ6RYmXvl4paLmiJs1LDk/mZtBGlJKOfUIpxVx/FAzxfZw/mwx/5vmJo8CvrChmnbzjPn1HKFz0ZxJ0AENLBlXX7mLIG9qJQs+PQ+G7nHYaWYuo1DgumAQJLwkdHCDBb6r78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S96EPfOC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iu7yQySe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773929664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05ZLtwPhIcLryILrFOZd9fzma2aS/obGeE4L6IYUapg=;
	b=S96EPfOCvTZ4Mp/+RS50ULM/OWw2DCnZg+u3DYB6yznV717BJ7aOeNJ5/54gphZFxgF+x3
	1/38S3oHI4NT9+Nd8Q6qFaecmG03LdpGPa39QV9oTE3CzoJkmX881xZDT3OuWu+G3XgmJ5
	d/Sqfwmpk/y33Kv4FlhBVpVV3R8vjOY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-0-80q41_Me21wJ5RswyG9A-1; Thu, 19 Mar 2026 10:14:14 -0400
X-MC-Unique: 0-80q41_Me21wJ5RswyG9A-1
X-Mimecast-MFC-AGG-ID: 0-80q41_Me21wJ5RswyG9A_1773929653
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b4085da48so701579f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773929652; x=1774534452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05ZLtwPhIcLryILrFOZd9fzma2aS/obGeE4L6IYUapg=;
        b=iu7yQySeGbzO2g7rk6w8DZjWVZ6kevMjkjtO1iU+JzIMHNjn3uKj5UkF7MNvYCEvsY
         JE62HhJvC3xXbXlbXURPyIR6n4c9ub4y5IjkL34ibyoRnffm1G+1/cjQ50SZ4hMXZ6gc
         MMQArtt7TdZNQTLnDyvpTE/FZQ5MQzzMQ8Q0xkJfYSZHHXqhT/fn6jGMv5fU424w1Lwn
         bbc0ZneuVfDM+1c/3FWEW5igLySN2tDVxGqlJ5xeTZ5PoQec9BgJ3t/CcaXUeRyzLOSS
         RsCCvv0aaEBaHrHG3RSPXcPHJw9svinfQ91IobkaC+trDYr3S5I5fMEbUj7Ftvj9uo/c
         6hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929652; x=1774534452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05ZLtwPhIcLryILrFOZd9fzma2aS/obGeE4L6IYUapg=;
        b=iFxKXqKDOUAXnqQmHPx9X+29BpEAJcKEuIC6872ZxaNKkPy57Lzqr7JxECZu/IUqno
         YeKaA4tsP3Pi4Bn1Qu+ULG4q9e8dDyvvplPCVdOpZHx45HIiJalx7UddhxEbGUbNxEUB
         51vQZySfYnsDJECbctDdJptbEkeJISX4zDaLBGEiH71H7rsM4bf+2eVpiQ5YNQnFdMX4
         1xTS3vP+4/F3xGCyudWVRQR2hD0LcyK8TcF2rdgOsm6nSmh5RoAmHfkMRo95y1EdnMYB
         WWwtW/G+pm1itqOYYHnAfijNwrjaHBXP0z5NXQdQQuvMz9H4oDGZkJyRf/8UyY+ems5/
         nLLA==
X-Gm-Message-State: AOJu0YweCxj9yDrMwBDY1EAVvwwzCQsBgmIVu7LbnDGZUyLPQoOP98Wc
	Z6pOhLMgkvhC2MW79b3MWyO/ND7b9hoejdNZgWszEtMdJ4iVhHu0iAnQy6Iv5oF2SVmThxRhkIg
	rNFYCPAtxFpV3tupce8cgoB0QCx7qnsDbFbgqg0Ejs2sJxNmYLDU5537LjXn7QRmrdA==
X-Gm-Gg: ATEYQzzxcnagG9X2kAURHWXHRfUBfYFLleLs/KfSH0ylx5L7mdP4ONfM33LgLKip5l1
	CKvW7e3rQZ4Bfyd8RLXF8CXr96oSPDQOlX/2a3gih6q3Etao88tr1hw03j2Qs6k5mT9oG7d5iGE
	sO9yQ5SacoxbuswBfGc4Jw8E3NU+LRutC3EXboHCH2vwMUCnXFLDdwQwrpch6Cpfc8jnfMIBKlE
	FzBcU7oF+tad7qTg5LL/fbcD0BA7V0RDnhGc249F5U28c1g7OpVdXSfOzlgmSufsC0Hk1Qfg5rp
	xMhvo+a5ykQLv37Of8P1Jop7TPhNZ3jFhRHZFv/le65GWC5u0303RtjfX3EyfupR5RNR14IiLGN
	7JIf4Hmx/3NpRZ+Mum5pGE8XOWIGIq1edKvYBsvqrfrNfg6NVUUxcx5lh
X-Received: by 2002:a5d:5887:0:b0:43b:4d25:959b with SMTP id ffacd0b85a97d-43b527a97a6mr13497150f8f.17.1773929652431;
        Thu, 19 Mar 2026 07:14:12 -0700 (PDT)
X-Received: by 2002:a5d:5887:0:b0:43b:4d25:959b with SMTP id ffacd0b85a97d-43b527a97a6mr13497081f8f.17.1773929651885;
        Thu, 19 Mar 2026 07:14:11 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a2cd3sm14518317f8f.32.2026.03.19.07.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 07:14:11 -0700 (PDT)
Message-ID: <c1fe7bdb-2e24-4dcc-a804-4f1f180eb4bc@redhat.com>
Date: Thu, 19 Mar 2026 15:14:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: net: add tests for filtered dumps
 of page pool
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, donald.hunter@gmail.com, shuah@kernel.org,
 matttbe@kernel.org, chuck.lever@oracle.com, hawk@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260319035649.2396137-1-kuba@kernel.org>
 <20260319035649.2396137-2-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260319035649.2396137-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,kernel.org,gmail.com,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-269455-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A2B592CCA19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 4:56 AM, Jakub Kicinski wrote:
> Add tests for page pool dumps of a specific ifindex.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/nl_netdev.py | 119 ++++++++++++++++++++++-
>  1 file changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
> index eff55c64a012..ceb44c8e1fec 100755
> --- a/tools/testing/selftests/net/nl_netdev.py
> +++ b/tools/testing/selftests/net/nl_netdev.py
> @@ -9,7 +9,7 @@ import errno
>  from os import system
>  from lib.py import ksft_run, ksft_exit
>  from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_raises, ksft_busy_wait
> -from lib.py import NetdevFamily, NetdevSimDev, NlError, ip
> +from lib.py import NetdevFamily, NetdevSimDev, NlError, defer, ip
>  
>  
>  def empty_check(nf) -> None:
> @@ -255,6 +255,117 @@ from lib.py import NetdevFamily, NetdevSimDev, NlError, ip
>          nsim.dfs_write("pp_hold", "y")
>  
>  
> +def page_pool_dump_ifindex(nf) -> None:
> +    """Test page pool dump filtering by ifindex."""
> +    nsimdev1 = NetdevSimDev(queue_count=3)
> +    rm_nsim1 = defer(nsimdev1.remove)
> +    nsimdev2 = NetdevSimDev(queue_count=5)
> +    defer(nsimdev2.remove)
> +
> +    nsim1 = nsimdev1.nsims[0]
> +    nsim2 = nsimdev2.nsims[0]
> +
> +    ip(f"link set dev {nsim1.ifname} up")
> +    ip(f"link set dev {nsim2.ifname} up")
> +
> +    # Unfiltered dump should have pools from both devices
> +    all_pp = nf.page_pool_get({}, dump=True)
> +    pp1_all = [pp for pp in all_pp
> +               if pp.get("ifindex") == nsim1.ifindex]
> +    pp2_all = [pp for pp in all_pp
> +               if pp.get("ifindex") == nsim2.ifindex]
> +    ksft_ge(len(pp1_all), 1)
> +    ksft_ge(len(pp2_all), 1)
> +
> +    # Filtered dump should only return pools for that device
> +    pp1_flt = nf.page_pool_get({'ifindex': nsim1.ifindex}, dump=True)
> +    ksft_eq(pp1_flt, pp1_all)
> +
> +    pp2_flt = nf.page_pool_get({'ifindex': nsim2.ifindex}, dump=True)
> +    ksft_eq(pp2_flt, pp2_all)
> +
> +    # Non-existent ifindex should return empty dump
> +    pp_none = nf.page_pool_get({'ifindex': 12345678}, dump=True)
> +    ksft_eq(len(pp_none), 0)
> +
> +    # Device down - no pools for that ifindex
> +    ip(f"link set dev {nsim1.ifname} down")
> +    pp1_down = nf.page_pool_get({'ifindex': nsim1.ifindex}, dump=True)
> +    ksft_eq(len(pp1_down), 0)
> +
> +    # Remove device, dump by its old ifindex should return empty
> +    old_ifindex = nsim1.ifindex
> +    rm_nsim1.exec()
> +    pp1_gone = nf.page_pool_get({'ifindex': old_ifindex}, dump=True)
> +    ksft_eq(len(pp1_gone), 0)
> +
> +
> +def page_pool_ifindex_leak_check(nf) -> None:
> +    """Test that zombie page pools don't show up under the original ifindex."""
> +    nsimdev = NetdevSimDev()
> +    rm_nsim = defer(nsimdev.remove)
> +    nsim = nsimdev.nsims[0]
> +
> +    ip(f"link set dev {nsim.ifname} up")
> +    nsim.dfs_write("pp_hold", "y")
> +
> +    pp_up = nf.page_pool_get({'ifindex': nsim.ifindex}, dump=True)
> +    ksft_ge(len(pp_up), 1)
> +
> +    # Remove device with leaked page - pool becomes zombie (orphaned to lo)
> +    old_ifindex = nsim.ifindex
> +    rm_nsim.exec()
> +
> +    # Zombie pool should NOT appear under the original device
> +    pp_down = nf.page_pool_get({'ifindex': old_ifindex}, dump=True)
> +    ksft_eq(len(pp_down), 0)
> +
> +    # But it should appear in an unfiltered dump (under loopback)
> +    pp_all = nf.page_pool_get({}, dump=True)
> +    orphans = [pp for pp in pp_all
> +               if "detach-time" in pp and "ifindex" not in pp]
> +    ksft_ge(len(orphans), 1)
> +
> +
> +def page_pool_stats_ifindex_check(nf) -> None:
> +    """Test page pool stats dump filtering by ifindex."""
> +    nsimdev1 = NetdevSimDev(queue_count=3)
> +    defer(nsimdev1.remove)
> +    nsimdev2 = NetdevSimDev(queue_count=5)
> +    defer(nsimdev2.remove)
> +
> +    nsim1 = nsimdev1.nsims[0]
> +    nsim2 = nsimdev2.nsims[0]
> +
> +    ip(f"link set dev {nsim1.ifname} up")
> +    ip(f"link set dev {nsim2.ifname} up")
> +
> +    # Unfiltered stats dump
> +    all_stats = nf.page_pool_stats_get({}, dump=True)
> +    s1_all = [s for s in all_stats
> +              if s.get("info", {}).get("ifindex") == nsim1.ifindex]
> +    s2_all = [s for s in all_stats
> +              if s.get("info", {}).get("ifindex") == nsim2.ifindex]
> +    ksft_ge(len(s1_all), 1)
> +    ksft_ge(len(s2_all), 1)
> +
> +    # Filtered stats dump
> +    s1_flt = nf.page_pool_stats_get({'info': {'ifindex': nsim1.ifindex}},
> +                                    dump=True)
> +    ksft_eq(s1_flt, s1_all)
> +
> +    # Non-existent ifindex should return empty
> +    s_none = nf.page_pool_stats_get({'info': {'ifindex': 12345678}}, dump=True)
> +    ksft_eq(len(s_none), 0)
> +
> +    # info.id should be rejected for stats dump
> +    with ksft_raises(NlError) as cm:
> +        nf.page_pool_stats_get({'info': {'id': s1_all[0]['info']['id']}},
> +                               dump=True)
> +    ksft_eq(cm.exception.nl_msg.error, -errno.EINVAL)
> +    ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.info.id')
> +
> +
>  def main() -> None:
>      """ Ksft boiler plate main """
>      nf = NetdevFamily()
> @@ -265,7 +376,11 @@ from lib.py import NetdevFamily, NetdevSimDev, NlError, ip
>                napi_set_threaded,
>                dev_set_threaded,
>                nsim_rxq_reset_down,
> -              page_pool_check],
> +              page_pool_check,
> +              page_pool_dump_ifindex,
> +              page_pool_ifindex_leak_check,
> +              page_pool_stats_ifindex_check

It looks like the new selftests are consistently failing?!?

# 5.79 [+0.24] ok 10 nl_netdev.page_pool_ifindex_leak_check
# 6.21 [+0.42] # Exception| Traceback (most recent call last):
# 6.22 [+0.00] # Exception|   File
"/srv/vmksft/testing/wt-2/tools/testing/selftests/net/lib/py/ksft.py",
line 338, in ksft_run
# 6.23 [+0.01] # Exception|     func(*args)
# 6.23 [+0.00] # Exception|     ~~~~^^^^^^^
# 6.23 [+0.00] # Exception|   File
"/srv/vmksft/testing/wt-2/tools/testing/selftests/net/./nl_netdev.py",
line 344, in page_pool_stats_ifindex_check
# 6.25 [+0.02] # Exception|     all_stats = nf.page_pool_stats_get({},
dump=True)
# 6.25 [+0.00] # Exception|   File
"/srv/vmksft/testing/wt-2/tools/net/ynl/pyynl/lib/ynl.py", line 1385, in _op
# 6.26 [+0.01] # Exception|     return self._ops(ops)[0]
# 6.26 [+0.00] # Exception|            ~~~~~~~~~^^^^^
# 6.26 [+0.00] # Exception|   File
"/srv/vmksft/testing/wt-2/tools/net/ynl/pyynl/lib/ynl.py", line 1342, in
_ops
# 6.27 [+0.01] # Exception|     raise NlError(nl_msg)
# 6.27 [+0.00] # Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink
error: Operation not supported
# 6.28 [+0.01] # Exception|
# 6.32 [+0.04] not ok 11 nl_netdev.page_pool_stats_ifindex_check
# 6.32 [+0.00] # Totals: pass:10 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: net: nl_netdev.py # exit=1


