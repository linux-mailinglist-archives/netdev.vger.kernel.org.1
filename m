Return-Path: <netdev+bounces-278368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGpUEeQK3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:37:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F893F80A2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB3473076EE6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FF3C342A;
	Tue, 14 Apr 2026 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="gCYjw9Tw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33873C7DF1
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159241; cv=none; b=FlaZNa1kxQPXfNMeZY3uiS6N6J9JRZrRUw6M3x9RqahWaLLXLTSG3dosocC8Gu6+2cXaHfyNRi98oE/QDYNi/Bu8HebflZBSxw5j3jNwNfVdQ2f2RD04fVKlEx/Zx0+XfiCTHdrxoliSnkRxfHINJRt11cWoFfRc/Epw2KwIcj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159241; c=relaxed/simple;
	bh=qpIuniXDudM0XboRaWxykSn2rrqlQMfFwWmEQwMUzO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8e8/4j8dogqHCFfQ5Xvm0KLeZfMnzHz6fl6B5BtRudX7pzJ4IWtli05QPRYHH3KpjaOW7xRLmonjW5ls3HQnpEz8+f/wIVyuzgdCQyl/889iTPySbJxACcCjNWbwJnfHJ92kabv9EaddQwSs6WvnT9UJNHzTUFIoV1UWs/Fo+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=gCYjw9Tw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so37148165e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1776159237; x=1776764037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5D/wg1b6VK+Oa91JECSbBLRKMJ3Bb4xR5XlVGb/8nU=;
        b=gCYjw9Tw2+APQ4Zmes3eCrEkRXxIG5LQYdjkiRQJS8DXncvQwnnjL6e39xkEWZPzqW
         OK1LZ4/ITm3Oe8L2g9Cgb3h2geWV1QNBbrRohBon5Pnn9FbqFH08UcgLXgGR+wGf+epZ
         wyDRwmSqYGUEX0or3ZI0AixsxBfgA7HjKxp+Dv4yLToC+4QESpBj3tzcbRbZthE2uTn0
         sJdV3c+knO48W8Qtrc1mXy2hONPfGiD7HYz/SdEmYgIOM0A3rvzPVQ2LqqwO9nGbb8ZT
         nZJI/UC4R6ufHaQi08itB4TFjsBd7xnFxsPCK13lQSqTjsiRPPVuw8ggk25KoKV6l+/d
         AWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159237; x=1776764037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5D/wg1b6VK+Oa91JECSbBLRKMJ3Bb4xR5XlVGb/8nU=;
        b=qoxKrP7CRfUkpU0c6Xj/B2ahP3aqhHiOiy2cNBxxEjEzAM3OnITZBrGWItbQvUCWE7
         bxycu3svZ8/pivSIfFk5e9OgDKYHkDNjIpvNHNOlGJRRlA5NvXglEVhUbm/jIQSnDcmN
         mHMSlZKjoobcY5lUV14/nB6lzBE/PZC3LeVK5AT4W8k/QKnNrVz9h2SOn6VovrQ4XQmq
         X4/PwFBSJG4ZlzI+I1CK19rf6uvXAX+jgQz77S+9nil83CxXJ/B43Fih62T4tomiaz8g
         MzVmhcyuz+xLUMSZBygyjwTnn3aZmF1NB0N9ckjgSuL8Ab0hHbOXePRi5RmAuR/bWc0U
         ofXA==
X-Forwarded-Encrypted: i=1; AFNElJ9eN9r7URmcKWJgYnA8Xp7+ckV5QdAJBoXJSozfMf85BeNLCu9Wtrz+/pwSoQde1MnfPqeudOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfrRUxKasDwEzX1y+6FBuHvqn3c8eFlYU9INIQtZ2EHRSa+018
	r2SiWvq+EbCwrD7wqQHlYGbeYlRRjQZWwOVrpCVCBt095O07NBp6i4Kz/5fYsT2Ui0M=
X-Gm-Gg: AeBDievtiMMy3EPSaLLzRZ6OZHQ+ddZhUAhJ7yjGcToCQNharmNgPALafhQ/NzI/rAs
	G0DnAdTzR6ZaQrZbaHtrPxtha7Oq7M+klEMiMRMd9G84B6YOAK4S/oZ3sNPymmHvCXGqKj4BpBi
	469TSJZM4jiwEoGdprW/qcSY2eSekcZpJjfmg2Evl0201tOfTZAZg/Nlj54r5gGwecvaA+MXxzz
	3ekAfyWxt4HGqooN9eZ4jNtMcBO74yy8r6ToCMWFSJVLMtu6CAj2MtvCrxDbEL/Tu36iigBwJZb
	SmCrNw3E3keWvqce2HFhVKp1eAgT617tBP+2HVvLyJEKbzUDk/6mKw2bIQlL3KrUVmi4rqnyMT7
	HY2T+iYmVFUBFd4+cDiTxtHUh/mlIPh90knDu6sE/XIHhNmpnNiAJAwwerYoKFmKx1kqUlWkY1r
	Hf3hspSoOJ01DzU1Q89k/8vCjV8WoWSZ00EqptBkq1VOclBltSls6DDPEVs+s7pTds
X-Received: by 2002:a05:600c:450a:b0:488:a882:b7 with SMTP id 5b1f17b1804b1-488d6ad17e6mr217660055e9.29.1776159237157;
        Tue, 14 Apr 2026 02:33:57 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ecde5b26sm48082835e9.2.2026.04.14.02.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:33:56 -0700 (PDT)
Message-ID: <f02a8b8f-bb27-48f1-bae6-2cda240a79d0@blackwall.org>
Date: Tue, 14 Apr 2026 12:33:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: use a stable FDB dst snapshot in RCU
 readers
To: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, vyasevic@redhat.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn,
 enjou1224z@gmail.com, zcliangcn@gmail.com
References: <cover.1776043229.git.zcliangcn@gmail.com>
 <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278368-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,kernel.org,redhat.com,lab.ntt.co.jp,gmail.com,lzu.edu.cn];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2F893F80A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13/04/2026 12:08, Ren Wei wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> Local FDB entries can be rewritten in place by `fdb_delete_local()`, which
> updates `f->dst` to another port or to `NULL` while keeping the entry
> alive. Several bridge RCU readers inspect `f->dst`, including
> `br_fdb_fillbuf()` through the `brforward_read()` sysfs path.
> 
> These readers currently load `f->dst` multiple times and can therefore
> observe inconsistent values across the check and later dereference.
> In `br_fdb_fillbuf()`, this means a concurrent local-FDB update can change
> `f->dst` after the NULL check and before the `port_no` dereference,
> leading to a NULL-ptr-deref.
> 
> Fix this by taking a single `READ_ONCE()` snapshot of `f->dst` in each
> affected RCU reader and using that snapshot for the rest of the access
> sequence. Also publish the in-place `f->dst` updates in `fdb_delete_local()`
> with `WRITE_ONCE()` so the readers and writer use matching access patterns.
> 
> Fixes: 960b589f86c7 ("bridge: Properly check if local fdb entry can be deleted in br_fdb_change_mac_address")
> Cc: stable@kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>   net/bridge/br_arp_nd_proxy.c |  8 +++++---
>   net/bridge/br_fdb.c          | 28 ++++++++++++++++++----------
>   2 files changed, 23 insertions(+), 13 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

