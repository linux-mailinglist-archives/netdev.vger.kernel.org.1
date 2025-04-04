Return-Path: <netdev+bounces-179379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33B8A7C33B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 20:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11E517CF96
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB421212B3F;
	Fri,  4 Apr 2025 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIMTbIAZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AE33FD;
	Fri,  4 Apr 2025 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743791289; cv=none; b=jbF/8/Fxbfgm9lXyBLjW/ul4SDjBhhZdwDdUvOXpKCqkpYHlrJY1qD6jb9QG9YrJOnrseV0GvBVRhdSYO1bdjttp5Jm0J8ZSFlWhPBiMI3itXvJImP+4AVCjtQR6SB8We0nPXd0UZsQ/tomC6IVt8rbJIglHElv2gcIB6aASCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743791289; c=relaxed/simple;
	bh=DglMbpkzGjQtfTLrGwSVvvXlRQMXQ19ZNDS/51mvNp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7txwyLoPo/mrvMjZOBjx9cNkFOm35QAf74WMTsdjE2uLnsfziIfTIp4LkMZMv1vxvC9e3zu8v8OPF+RaSYmzT/vwlHPncVV14yg2LmAZRpj947KCCLRJNHpSaP7QKvYGte3lmNsohwdPhO9bl3yM7Gad7vZLx1XJVdNrZi++mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIMTbIAZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ede096d73so2612465e9.2;
        Fri, 04 Apr 2025 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743791286; x=1744396086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vX8L3znb4PiOY8Mv51B0TXVAFHt79CJkCJAUGNMOpc=;
        b=EIMTbIAZwPmnRsQ+Bwz383haT8R3IA/hoYjGBM/kCXHiSbravgkrSmY8moak2M5f/l
         /X/17Dtk/BUgeETMiki10RuWdS7viNGedCgzanCABgSzGvvxMy8BuaxQ3KkZOPbarzSF
         E59YIFyntfDtFpNT5B30n1HZ5bwNAAtjcZ8c+PPq1Pz2kfPNHCd5vwjdg1YJWm++fSZH
         Olh83uyf16Oi9Igda1qCWXXFDBpOopFi1qtb7Sjjix2+Bowqb4RjcmProx87L0Aa2ZGp
         j024w5Ecn9Cwi+xs07FfRQFS9rSHZQQqs85xMKQ3FAUB6LOa47Oq/qbLCrHXyzHPKb7Z
         7cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743791286; x=1744396086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vX8L3znb4PiOY8Mv51B0TXVAFHt79CJkCJAUGNMOpc=;
        b=NnA0lWXKVBFFcelt9QrN4HFzsf058D7pozJA7PzE0da+fLJpgqIko7KCFV9qauf99e
         CeJzNnysGWZZJVk0JvAL5oWLtD20onxYRzzvtxYaQG+/cpv+wLG7OWI3gIGCd5+cNNE4
         XEQzrKxKaTjXqdSCyyKnnPDcBh1+T1XiyumfYikGxTmwYhrG2qxMnyCABZxiFj0AdbWJ
         fVqPtz2TGl2debGr23tspc7zoGMD5ZQEy6WgrRhybOSJLRZrpy3HcR5uAGOO8KfZ1rT9
         8H96XRNzrxG6B1M4VTp7c23ExJRt7kihEzuiWspllmwBtKH0gfBXfjb75Tzj+0E1HoQ8
         zy9w==
X-Forwarded-Encrypted: i=1; AJvYcCVjSjgyWjG3eV5MHxxCtajRsnmFAX1yUwZJ11W4ePblm856TXo+C1dcdPqCfOYtG2aWyyz8ht4HLp1JcQw=@vger.kernel.org, AJvYcCXzjXxprGLll3kVIhMDJz+8CurYGaxBcR60WGmQp56nJoVpnhOzCuhpJmojmha0+uWZ2Mc/0xen@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIttuCMjZ9C+Rfu8N2FldQCtALfX6k5lQ4PmfUnnmCrVRjhIW
	daKXnp6J4DuIrGRENpN+wlZ9k6F6W3gutSSAiBLS/Wf3UNZJ+cUF
X-Gm-Gg: ASbGncuSkzL2ax7OBB45fQWCitvW81RlCUHskNZaYmEukLcE2jd1cznCCYbDEidNjOw
	AZVFghlYxS4o6zeKzDi3ZCMd6jZD139OfyVjkNMk07XLudRM9MPCq9Rl8ax07ZcM5nlF/BjhiJs
	fjf1wJEvRitycneSQtIz7T3zkJX8051eUvctHVEqoc5XFaYRGlxDS2NzKxXb1Bj2wQCJ/8liOTb
	w9rF8hrNP/f/aKxDUAbcVhePTc2w7yUIw/PVHFJfaf/wc0dsX4YOov0tmFwbyq8/V7kjL74ZCPt
	I0cFGVuy+F3ZtXz2E6OeNj8+eYNqOb2DpcgJiGzUkikdq7se
X-Google-Smtp-Source: AGHT+IF1/eepOaIp9QlGAjPtm96uos5iqsoWF//NfMBRrB0cNjIUFBWoUTRNSgw0T5NT7ur5UFRN0Q==
X-Received: by 2002:a05:600c:4e47:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-43ed0bc8dbbmr47581745e9.10.1743791285972;
        Fri, 04 Apr 2025 11:28:05 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630de9sm55476465e9.1.2025.04.04.11.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 11:28:05 -0700 (PDT)
Message-ID: <d74daaaf-4e66-4cc7-a74d-eb5d89e017f1@gmail.com>
Date: Fri, 4 Apr 2025 21:28:33 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: wwan: Add error handling for
 ipc_mux_dl_acb_send_cmds().
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Wentao Liang <vulab@iscas.ac.cn>
Cc: m.chetan.kumar@intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250403084800.2247-1-vulab@iscas.ac.cn>
 <Z++G8b6DBd3uCd1x@mev-dev.igk.intel.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <Z++G8b6DBd3uCd1x@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.2025 10:14, Michal Swiatkowski wrote:
> On Thu, Apr 03, 2025 at 04:48:00PM +0800, Wentao Liang wrote:
>> The ipc_mux_dl_acbcmd_decode() calls the ipc_mux_dl_acb_send_cmds(),
>> but does not report the error if ipc_mux_dl_acb_send_cmds() fails.
>> This makes it difficult to detect command sending failures. A proper
>> implementation can be found in ipc_mux_dl_cmd_decode().
>>
>> Add error reporting to the call, logging an error message using dev_err()
>> if the command sending fails.
>>
>> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>   drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
>> index bff46f7ca59f..478c9c8b638b 100644
>> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
>> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
>> @@ -509,8 +509,11 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
>>   			return;
>>   			}
>>   		trans_id = le32_to_cpu(cmdh->transaction_id);
>> -		ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
>> -					 trans_id, cmd_p, size, false, true);
>> +		if (ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
>> +					     trans_id, cmd_p, size, false, true))
>> +			dev_err(ipc_mux->dev,
>> +				"if_id %d: cmd send failed",
>> +				cmdh->if_id);
> 
> Shouldn't it go to the net-next? It isn't fixing anything, just adding
> error message.

Michal, you are right. Patch does not fix a user's problem.

Wentao, could you resend the patch without 'Fixes' tag and targeting 
'net-next' tree (the subject should be 'PATH net-next v?').

> 
>>   	}
>>   }
>>   
>> -- 
>> 2.42.0.windows.2


