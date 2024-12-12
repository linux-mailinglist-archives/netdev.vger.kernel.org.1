Return-Path: <netdev+bounces-151366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9069EE6BC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469D3161322
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162B72080D8;
	Thu, 12 Dec 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI19At44"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B5207A3F
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006575; cv=none; b=W6KVBqw31o3NBTR9oAIbeflwSQi6yI+eFJEr/Z/Xk5h5DNrP0U/xkgbb3MTeiKiUE2+7ozySR8YuKVnj7CuYUSuGv9ajYHRtAYdjtuUEBzufJGMUIRRBwmVfgBZ6rtELzhvsXl6nluyLuRa5cNOdtSl3NgP1zzHw65DtGG1vEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006575; c=relaxed/simple;
	bh=METhm59BXBxoupPU1aWStj2DlPXmsrB4npAjbiA4tQI=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gLp+xfdheeMkkIf7k2r+GpkVendhpjjnY60jMupvgkrhD3adxHtvQ0z2sUOTLwoPin2cOWaZHtJY/GM9EMrXJmwA2ANP1+1uGJSVtj5Z4Yk0W5IO8a8Y581XDHdS1mSOBgwHyHt6lw2cs5Tbi19RuIWEFl/eEYbsz/DvVWlrENI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI19At44; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436202dd730so3776015e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734006571; x=1734611371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/unUC/AFKK2nzY2N3vnPzxwTEQ6e/xbHq55WDbqXHk=;
        b=XI19At44dynviXqnaC3eeAHDEpizYVMTtMBxbI/1lWFQn8YJrcMu0qyjDVhkgLzu5D
         KheUOG6/feRWCN+VANSgDnebVEVT94bBkn9np9ctA2nhRXCCGziiQxDjV3l2FgwN0Tjl
         h4ARR8H9PzUHvO3a14DeR/2BdxTbz0UzZvAzA+NEataIsxOJNS4SPeSUVZE7pXBDagHY
         PuMRwA5CbVhtG0QLlLjnybvZ/RqAmYlWVtCVuzD/vHcUj5rIgHCSC4BTkOARQefaK1WV
         589YIQiI08MtXG57ZsxqgaZHQyl/oJW2cORbVhZnDO0w/rRvgKIryTn/3yh1umsNkTc4
         UUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734006571; x=1734611371;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/unUC/AFKK2nzY2N3vnPzxwTEQ6e/xbHq55WDbqXHk=;
        b=qCDcN7OSZTGvDXaCkGPAxPUYp2ay3/fNb8iqGTjBh6wAE9n3PdLsOggwR9K9aWFjl5
         AT+D7LOvaL5bMj8/fPeUfUrPHHWwT9wwEn7MZNeg/Srg6eYehSBkx+bmWsPu3CHu33N3
         rq+0FKZBNV6USC5hHPIbdH4ZN6OUYbjWsoXMhR8fZReSNFw2czkR+xcdoh2a72iq4RVT
         TzUihhOs0uksd3kywjonzN5b/drqYcIC/TmO8hftVcP58H9F3/BK0pI9vJ2djKymQPYG
         ZWhuNmtU6tAnxWssthsC9hs26MP2iq3MdDV2rgDjPX0nHpjELbwGD015MuhaUN398hdm
         ZwrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSBJz22qpCeJ13JPKx+6TWdJ5VLM4oq/Ptda2bF6tA5ax4Arsgg+TSSDcbndvf4RObsE3VCI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCzRYzXn9w8iD4A3i7nTl+nK1odu6eWfLUkzv+mEN+gjjkg/E
	QQ4kuPWN5FJ6qA3aX4obdPYmerdxZfuzQU8/fFHiQCAc4ensf/7zWLcoAA==
X-Gm-Gg: ASbGncvh5deBOFBeRvDzRckARsIhK8BO8cIFhb+3MK9vGTmHIfxB0IWv/b6R02FrA1x
	1ShHxTtkMsHLkASqa+Rq4AoHzPzQ9UE+tn/OXiSlO7zHe0NPOeJHThNUHd5XFKAfBoSuA+cVHD1
	nxoi9qCsDir3kJszLnbpErDS1l5/JHbzy2sW33ZosyvvMjGFJBMssH0PMQJcyflEw+8fDjhhsWJ
	43LUM4Ziw7fsBF5RIxDgZULxCTePTj9WvckNNhDBhUikVdJqD8OzuhmWqtdrFpu9v7W7tT3guN4
	qpkYwlqkO1TeKhyyJehitxFd7T0Nl3SaYSjF4Y6i2+xv
X-Google-Smtp-Source: AGHT+IGvl8Fqb98PwWU4SEZAs34yMnnMOZOuJDtC3GCq+MTMZN7S636kqVXD2h7NIUwGKr/Ua4GSCA==
X-Received: by 2002:a05:600c:1e89:b0:434:9fac:b158 with SMTP id 5b1f17b1804b1-43622823874mr26769755e9.1.1734006571293;
        Thu, 12 Dec 2024 04:29:31 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625717c9fsm15175615e9.44.2024.12.12.04.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 04:29:30 -0800 (PST)
Subject: Re: [PATCH net-next v3 02/12] net: homa: define Homa packet formats
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
References: <20241209175131.3839-1-ouster@cs.stanford.edu>
 <20241209175131.3839-4-ouster@cs.stanford.edu>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <5d9d563c-a321-cc75-a986-49ddc1935681@gmail.com>
Date: Thu, 12 Dec 2024 12:29:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209175131.3839-4-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 17:51, John Ousterhout wrote:
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
...> +/**
> + * define ETHERNET_MAX_PAYLOAD - Maximum length of an Ethernet packet,
> + * excluding preamble, frame delimeter, VLAN header, CRC, and interpacket gap;
> + * i.e. all of this space is available for Homa.
> + */
> +#define ETHERNET_MAX_PAYLOAD 1500

This would seem to bake in an assumption about Ethernet MTU, which is
 bad as this can vary on different Ethernet networks (e.g. jumbo frames
 on the one hand, or VxLAN on the other which reduces MTU to 1460 iirc).
In any case this define doesn't seem to be used anywhere in this patch
 series (nor in the version on Github), so I'd say just dike it out.

> +
> +/**
> + * struct common_header - Wire format for the first bytes in every Homa
> + * packet. This must (mostly) match the format of a TCP header to enable
> + * Homa packets to actually be transmitted as TCP packets (and thereby
> + * take advantage of TSO and other features).
> + */
> +struct common_header {

Arguably names like this should be namespaced (i.e. call it "struct
 homa_common_header"), as otherwise some other kernel .h file declaring
 a different "struct common_header" type for unrelated uses would cause
 compilation errors if both are included in the same unit.
Some of your typenames are namespaced and some aren't, and it's not clear
 how that division has been made.

> +	__u8 dummy1;

This is the flags byte in TCP, right?  Seems like you'd need to specify
 something about what goes here (or at least make it reserved) so as not
 to confuse TSO implementations.  I see HomaModule defines it as filled
 in with SYN|RST, at least the commit message here should say something
 about why you've not done the same in the kernel.

> +	__be16 dummy2;

Again, specify something here, even if it's only "reserved, must be 0"
 to allow for future extension.

> + *    No hijacking:

Assuming you don't intend to try to upstream TCP hijacking, this line
 probably doesn't want to be here as without context it'll just confuse
 the reader.

