Return-Path: <netdev+bounces-259247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI4ID86MlWl7SQIAu9opvQ
	(envelope-from <netdev+bounces-259247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:56:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC0154FDD
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 337423074F17
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F364C33DED1;
	Wed, 18 Feb 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RpYY+yZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676BE33D6CB
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408430; cv=none; b=Q5rXdDQyDX0hnszeIJdlpz+1vTNwUE8V0vAUG7W4K5fvO9qRMPs84OC7DixeZnyw3Haa9+H1IFsecO/QvKNdKWFc+nJNOgkF6+d4eNGmRNuGyp322qBZTdXQGkSW7EPlsZ6g6fzP+88bZGxd5NIWSjnzjC49fwiZ7yoqfLRvtg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408430; c=relaxed/simple;
	bh=TeeLs3NcFkqm15bJUSAf9t2789KIXdBpT0wZHlnv5Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrxUTOgIFh+ALGVAH+Bo34SbtGHbjapW3+f9TaisClkX5jT13UGOiCmJeXaTxolfanSg5GWzsAPpP5jXuaBD2Tn6VupBhtjR03YZ9urJ4q3ZkETyowbOQqnzfb8vyTSwGf5O8er/UfXwzm5ogovK9LjoXdx5smpLmbxcg96TCRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RpYY+yZ9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-436317c80f7so428964f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771408428; x=1772013228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1ulvuax8cBGRk/QHq0GKPnGp3zOxTCBdDakRLwe+MA=;
        b=RpYY+yZ9HA74aiHr4hiCBeux0OO41YA3MUgGIheEBeWmHLHbVcA1qGgIJe4beazvya
         CLTovwmrx133ANyQxCyS2PEkROb7nNNYVBS5XhI4AuBB6U3Ta/5Stf+54r/6NUcwOy6W
         MurinXNnHM1lUzTKWqQIALWO98gPDpY3scNgCI3UJ43UH8rYr9oZe+zfdZF1WRW39zVr
         mYaVSIegdPMdEzB/Qk4qixuUSR8RCoNxxoHpx/rFrjAnfcJXaqQO1d2BVVRl2nsPmwDd
         GTbRO9eoM10eETEs3KdPv8ZnM2aDN2x2l6vxoUjbhgeisWmggCa6pZM/UNIfqeQozFTb
         yXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771408428; x=1772013228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1ulvuax8cBGRk/QHq0GKPnGp3zOxTCBdDakRLwe+MA=;
        b=JXw2IDkRRl9JMnkn/J5TpfFGPLoPQnH+JfRls8wai1CYbmafDqEoSk5OCxvijulWbp
         9A0goCNj87A1NwInWdLiRkjhfDzcRQxf+HiLC3uHhw0Qxr29y1rMHmuGJ6/wdlcsCkaU
         faR5HUGuOlRUt3VSdcwmK/IGFrB9pGgoFk+EXP7lHJjhmVa0uStmK7f+Cn+uNamZe7QQ
         iimxgQjh5I5RbSxW8ZYnlp/Z1ZvFzoo01Mutd5y0Nn0PwMJTFqtPUAcyQxTc1fRL0PPv
         nP1aF7j3aGBZIGyGKv310WsU1lBrSCxzkaoybRjjqlq3SQ42WaXWnbtAZ5wPfaMhtAu+
         ixRg==
X-Gm-Message-State: AOJu0YzTvTymXeokYS/MeOnljoUCUOf1xZQf32wqqMApMZMiE+MxjeU3
	S+LGzYru15vIM59vMurWglw5SbLd9q47N3osVVFipWgNkcJMZPbY5GmjmAcJw4O8/1XxcTYg6MC
	KhN8y
X-Gm-Gg: AZuq6aL6KZ0FXVpD7IdGZNXLBGmqhssWyoZpJs70+cGHhdrHyje1D6Af/zGWaFK9dwm
	0CNgrxyNV3UclAgTk8KkVxkCdr0HITNX5liKQgi1Wx6yofB5j5mocEr7OtQOmxkB2UgDY0V6/98
	0p69enc5zWXIVDyK//jEJtpQjUUTgZfkUiZJTR6OYxIQJTWBI7BPsZiUGONcPV7rhNPylFCXLON
	uLf4d+G/376Y4ne23bIqzYuL447Op7BGdyjfN05qfgnA/8+0+unJBpIGOOLFllgzNf+jcFRHVOM
	11ZgG3UffhNJj62TUNDCpDeQ283h+o2tdOtDVLkQESI3N1c0/CGWgVWj72s1RZL0S2Ju/IaQXIj
	q6kYp7jC6Fn1hsBVqFxFB9FfONSpj5PVZsSEkPOH5/9pNY1tq1xnOcUHXBAvcUeQXDwLF4MoO48
	c8GwzXMeW4biKdTXN2FoBSXuBLOGVL+Gv5CidwN/OwLdfHR0RqWdx/U3VKw+xzPFsgaPEETQpm7
	JtdQA==
X-Received: by 2002:a05:6000:2dc7:b0:437:71cc:a237 with SMTP id ffacd0b85a97d-43958c5a7e6mr2364630f8f.29.1771408427749;
        Wed, 18 Feb 2026 01:53:47 -0800 (PST)
Received: from ?IPV6:2001:a61:13d1:a401:31a6:f06b:8297:f001? ([2001:a61:13d1:a401:31a6:f06b:8297:f001])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796acf5b9sm38808978f8f.34.2026.02.18.01.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 01:53:47 -0800 (PST)
Message-ID: <10f24161-3021-4f0c-b3b3-5a5dbe7c746e@suse.com>
Date: Wed, 18 Feb 2026 10:53:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/3] net: usb: divorce private data and cdc state
 in usbnet
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hayeswang@realtek.com, bjorn@mork.no,
 o.rempel@pengutronix.de
References: <20260210151416.42254-1-oneukum@suse.com>
 <20260210151416.42254-2-oneukum@suse.com>
 <5b017c3f-7c84-4769-b324-5cb92d6b56a7@lunn.ch>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <5b017c3f-7c84-4769-b324-5cb92d6b56a7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259247-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 92BC0154FDD
X-Rspamd-Action: no action



On 17.02.26 19:23, Andrew Lunn wrote:

>> +	unsigned long		private[5];
> 
> private would normally be a void *, since the core has no idea what
> type is should be, it is specific to the driver. For this patch, could
> you make it a void *, and set the pointer to a block of memory
> equivalent to 5 unsigned longs.
> 
> You can then remove all the casts in the drivers, making the code look
> normal for handling private memory.

Hi,

understood.

	Regards
		Oliver


