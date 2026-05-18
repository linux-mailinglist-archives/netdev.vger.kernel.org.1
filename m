Return-Path: <netdev+bounces-289002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJumHdD4CmpZ+QQAu9opvQ
	(envelope-from <netdev+bounces-289002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:32:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1AF56B98D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC7E7303A929
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9283381AF;
	Mon, 18 May 2026 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="azpP8G4K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556BA3F54D5
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102850; cv=none; b=T31cM0HWMnU7x3Y6k4UMnebLSoIJ25Xfl+T9j7qOrfr1lq0IjPrXlncqM74NIDOiA1eiATF5m7UiGmXPN1xliLTVqniTPFCY5E79J+3qhN9axfBPK+KJGcBNiaFmGI910YIfazdkxQNWBYTIhT0tGbp4XtI1Siu5ADYP1/TV/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102850; c=relaxed/simple;
	bh=vdx3XzVtOcOKmMPxfLyFvLhKXbnHezrSE7ELE6kNcCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWne9fRmqp1n46+Lvn9qDQ6Emkjp9EAg6ANWfdIUzw2S4fwUyI9QtFfIGdmc27BEtlxLWLPIB+Dk/P+YQWoqNbszDHCR6d+vhW23yeuLFdelBCIg4HzKiU58F0DYpPnkad9n3aZ2IN81qhJt0EG/O0vAV3sdUmebLjzknsadTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=azpP8G4K; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48d102471a4so17246205e9.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 04:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779102835; x=1779707635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTpyX8U2wWPzmUy3PwYrSh5BYJ7W5T6xVD69AH/626A=;
        b=azpP8G4KQ4sNw3gobK5ibHgTEMSjidrhYeqmbmeeCMrWQ0WN8qCZSpL3SuFR2Wl9+r
         hCRBOSi9V9OTZEuo2u6HkDsd8DhEgcRNmxLKvNaWLFbCQU07hwFVo5D1+zdbUoB0Aq82
         x+bs+T/xaFSUsDhWVYu3k2DCZIloTo9RZWEOUNp6kwToYmWTYuTceGk3fVJ8+Kc5TLBf
         UesM0QQQFIPZzxT8bPAx8pFYYdP0I1V+7WPoY+EM0LICPm6StjVwxQD10Uf5akm58K5t
         DFbxrc1o88Hj1Y4euhOXR5zWffJ3T1cL4UtCONJLmYYH9osSGSmhZdl6d6bf8iptP9Xt
         HPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102835; x=1779707635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTpyX8U2wWPzmUy3PwYrSh5BYJ7W5T6xVD69AH/626A=;
        b=NME9JHNeM1SXuWeruZstSFm6SpvdXY0EbIzoW3p//jhS8DWCvg85pzNEWCwAurxt1n
         0sjS3DvCLcpP5OXaPR2jFnboHo/nJZRqX/ocWU1syjiuK2I4lsDfDA2YqyNwBAjIUydg
         PiXKaXi/qeGLIDuI1YBYfB3oLJNv/CRT/v6WjIaWEj3DyD1/GAl3d6K2MsgCiUSshce7
         ynlFQ4+v2Y6PNA2JSKeLINjBQoGSGvq0Z/bj1iJYgP9WqdeH8yNQHV2DwWxlfOCGIOmr
         uOjXqvX8UES6tMhepGm1CrNIRcb12eGI3Kje9xH1CEawK5yO/R+4VFYVwsa5d0+lrc0u
         1faQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FYKpl4FLhsnU6SnWOweTFUJKN7kqj/pBU2EciY4QUHb0/YtWXaCxwPIJJufrYV2OiorUUhXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8COsOjfIMePpUyJvU3CzSlfn5whqqMrUTgUq/bv5LQjUtAKt
	UDDmkSqefzS6HZiKsR9vHC8jBdE1LbPrBEIs1eAoWkrH2uwBRZfQb6iED93B1ihqEVKvR/9ZB2V
	3Z9Y3vg==
X-Gm-Gg: Acq92OHP5+6dvnlZBAMh0EHW2xFSlHXblHrx2CeDMYGfZSALlm8FXyqpcKcjX8hvzzC
	ugs45cb3HAxg1192XjxlfWfjjqZMYlNlu4dwU9xC07CYi8Rtg/3iu8y4e/7I/OfbyVAPInl2IR3
	Jf5s9o/0iq73GnjiZwmtxA1MADa8fjgcQJh4hjSLKi2gD4iAQgA7xJGay4qXt02qW02K5TaCIxj
	7KWjFtVAca4Vzw6wM52MJ8ntRqkdOMh+Upd0HP5BO7DJQ03YzL/9MeovawJwevA9z3rODzI6K66
	0o4PVIsQaZarttQBUT24jfxBmF9rckJszputzEd0iF4KwTjzPiXh30zh8X8aytHWuzwC+iGrOYo
	W6dMQKiC0D2CO6Ake/AW3cUFqf2i3ctNH8aeiwmSCDVksQhBF3YsklR/ruoDT9QcLbzMLVjKG/Z
	ggSBb0cwv+7EXP2ZEg8R0AF5k=
X-Received: by 2002:a05:600c:8209:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48fe61f2a2fmr232263095e9.16.1779102835180;
        Mon, 18 May 2026 04:13:55 -0700 (PDT)
Received: from [10.83.43.186] ([159.134.255.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm236662155e9.12.2026.05.18.04.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 04:13:54 -0700 (PDT)
Message-ID: <3915f01f-ca38-4e02-a3a9-0adf756e33ee@arista.com>
Date: Mon, 18 May 2026 12:13:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tg3: guard napi_disable and pci_disable_device calls
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: mchan@broadcom.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <CAPzpGcTtw+ou+8jid_qE9w96UWt+4KUZXN-aC=44Oqkk=qdERg@mail.gmail.com>
 <CALs4sv3XH1DEB+EXmSjKvPz8Av-53HOrJ+Dc_mjOv+3EnnuV9w@mail.gmail.com>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <CALs4sv3XH1DEB+EXmSjKvPz8Av-53HOrJ+Dc_mjOv+3EnnuV9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF1AF56B98D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arista.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289002-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurypm@arista.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arista.com:email,arista.com:mid,arista.com:dkim]
X-Rspamd-Action: no action

This is what I saw in our real environment:
[  475.568144] pcieport 0000:00:03.0: AER: Uncorrectable (Non-Fatal) 
error message received from 0000:00:00.0
[  475.568255] pcieport 0000:06:07.0: PCIe Bus Error: 
severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
[  475.703860] pcieport 0000:06:07.0:   device [11f8:8533] error 
status/mask=00100000/04400000
[  475.727967] pcieport 0000:52:02.0: Unable to change power state from 
D3hot to D0, device inaccessible
[  475.804002] pcieport 0000:06:07.0:    [20] UnsupReq               (First)
[  475.804008] pcieport 0000:06:07.0: AER:   TLP Header: 60000001 
0000010f 0000380e 00000068
[  475.916817] tg3 0000:49:00.0 lc3: PCI I/O error detected
[  476.094461] eth0: port 3(lc4) entered disabled state#8 #11  #1  #3  
#4  #7  #9 #10
[  476.096010] br1: port 14(lc4.42) entered disabled state
[  476.097188] eth0: port 3(lc4) entered disabled state
[ 476.097485] lc4.42 (unregistering): left allmulticast modC
[ 476.097491] tg3 0000:54:00.0 lc4 (unregistering): left allmulticast mode
[  476.097494] lc4.42 (unregistering): left promiscuous mode
[  476.097508] tg3 0000:54:00.0 lc4 (unregistering): left promiscuous modeS)
[  476.097513] br1: port 14(lc4.42) entered disabled state
[  476.224325] pci 0000:46:00.1: AER: can't recover (no error_detected 
callback)
[  476.224333] pci 0000:46:00.2: AER: can't recover (no error_detected 
callback)
[  476.224335] pci 0000:46:00.3: AER: can't recover (no error_detected 
callback)
[  476.224338] pci 0000:46:00.4: AER: can't recover (no error_detected 
callback)
[  476.224371] pcieport 0000:06:07.0: AER: device recovery failedy

This is PCIe tree:
#lspci -vvvt
-+-[0000:00]-+-00.0  Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 
v4/Xeon D DMI2
  |           +-01.0-[01]--
  |           +-01.1-[02]--
  |           +-02.0-[03]--+-00.0  Intel Corporation Xeon Processor D 
Family QuickData Technology Register DMA Channel 0
  |           |            +-00.1  Intel Corporation Xeon Processor D 
Family QuickData Technology Register DMA Channel 1
  |           |            +-00.2  Intel Corporation Xeon Processor D 
Family QuickData Technology Register DMA Channel 2
  |           |            \-00.3  Intel Corporation Xeon Processor D 
Family QuickData Technology Register DMA Channel 3
  |           +-02.2-[04]--+-00.0  Intel Corporation Ethernet Connection 
X552 10 GbE Backplane
  |           |            \-00.1  Intel Corporation Ethernet Connection 
X552 10 GbE Backplane
  | 
  +-03.0-[05-9e]--+-00.0-[06-9d]--+-00.0-[07-10]--+-00.0-[08-10]--+-01.0-[09-0c]----00.0 
Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |          |              
  +-02.0-[0d-0f]--
  |           |               |               |          |              
  \-03.0-[10]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |          +-00.1  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.2  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.3  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          \-00.4  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-01.0-[11-1a]--+-00.0-[12-1a]--+-01.0-[13-16]----00.0 Broadcom Inc. 
and subsidiaries Device 8797
  |           |               |               |          |              
  +-02.0-[17-19]--
  |           |               |               |          |              
  \-03.0-[1a]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |          +-00.1  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.2  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.3  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          \-00.4  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-02.0-[1b-24]--+-00.0-[1c-24]--+-01.0-[1d-20]----00.0 Broadcom Inc. 
and subsidiaries Device 8797
  |           |               |               |          |              
  +-02.0-[21-23]--
  |           |               |               |          |              
  \-03.0-[24]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |          +-00.1  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.2  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.3  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          \-00.4  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-03.0-[25-2e]--+-00.0-[26-2e]--+-01.0-[27-2a]----00.0 Broadcom Inc. 
and subsidiaries Device 8797
  |           |               |               |          |              
  +-02.0-[2b-2d]--
  |           |               |               |          |              
  \-03.0-[2e]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |          +-00.1  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.2  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.3  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          \-00.4  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-04.0-[2f-38]--+-00.0-[30-38]--+-01.0-[31-34]----00.0 Broadcom Inc. 
and subsidiaries Device 8797
  |           |               |               |          |              
  +-02.0-[35-37]--
  |           |               |               |          |              
  \-03.0-[38]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |          +-00.1  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.2  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.3  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          \-00.4  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-05.0-[39-42]--+-00.0-[3a-42]--+-01.0-[3b-3e]----00.0 Broadcom Inc. 
and subsidiaries Device 8797
  |           |               |               |          |              
  +-02.0-[3f-41]--
  |           |               |               |          |              
  \-03.0-[42]----00.0  Broadcom Inc. and subsidiaries Device 8797
  |           |               |               |          +-00.1  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.2  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.3  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          \-00.4  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |  +-06.0-[43-45]--
  |           |               | 
  +-07.0-[46-50]--+-00.0-[47-49]--+-02.0-[48]--
  |           |               |               |          |              
  \-0d.0-[49]----00.0  Broadcom Inc. and subsidiaries NetXtreme BCM57762 
Gigabit Ethernet PCIe
  |           |               |               |          +-00.1  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.2  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.3  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          \-00.4  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-08.0-[51-5b]--+-00.0-[52-54]--+-02.0-[53]--
  |           |               |               |          |              
  \-0d.0-[54]----00.0  Broadcom Inc. and subsidiaries NetXtreme BCM57762 
Gigabit Ethernet PCIe
  |           |               |               |          +-00.1  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.2  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.3  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          \-00.4  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-09.0-[5c-66]--+-00.0-[5d-5f]--+-02.0-[5e]--
  |           |               |               |          |              
  \-0d.0-[5f]----00.0  Broadcom Inc. and subsidiaries NetXtreme BCM57762 
Gigabit Ethernet PCIe
  |           |               |               |          +-00.1  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.2  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.3  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          \-00.4  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               | 
  +-0a.0-[67-71]--+-00.0-[68-71]--+-02.0-[69]--
  |           |               |               |          |              
  \-0d.0-[6a-71]----00.0  Broadcom Inc. and subsidiaries NetXtreme 
BCM57762 Gigabit Ethernet PCIe
  |           |               |               |          +-00.1  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.2  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          +-00.3  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface
  |           |               |               |          \-00.4  PLX 
Technology, Inc. PEX PCI Express Switch DMA interface

To do cleanup on device-stop or error handling is a common approach, and 
it is not a problem. The problem is that tg3 doesn't track the device 
status. If a cleanup was performed (napi_disable and pci_disable_device 
called), tg3 should know that the device is not in an initialized state. 
When we subsequently try to disable the device, tg3 should not try to 
cleanup again. That is the problem I'm trying to fix. Frankly speaking, 
I'm adding a flag which signals that device cleanup was completed during 
the handling of an AER error, so when tg3 stops/removes the device, it 
should not perform cleanup again.

Maybe PCI_ERS_RESULT_NO_AER_DRIVER is a rare case in the PCIe world, but 
I think that in any case, the tg3 driver should correctly handle AER 
recovery failure. Recovery can fail not only because of the 
PCI_ERS_RESULT_NO_AER_DRIVER return code. The problem is that a double 
napi_disable call causes a soft lockup, and not just one driver/device 
stops functioning—the whole system is affected.

On 5/15/26 16:42, Pavan Chebbi wrote:
> On Fri, May 15, 2026 at 4:28 PM Yury Murashka <yurypm@arista.com> wrote:
>> During PCIe hot-plug events, uncorrectable errors can be reported and
>> AER recovery for the tg3 device is initiated by the AER kernel driver.
>> The tg3_io_error_detected function is the AER error recovery handler.
>>
>>  From tg3_io_error_detected, we call tg3_netif_stop->tg3_napi_disable->
>> napi_disable and return PCI_ERS_RESULT_NEED_RESET on non-fatal error.
>> We expect that during AER recovery tg3_io_slot_reset and tg3_io_resume
>> will be called. But AER error recovery can fail. For example, when one
>> of PCIe devices on the same bus reports PCI_ERS_RESULT_NO_AER_DRIVER.
>> As a result, tg3_io_slot_reset and tg3_io_resume are not called, PCIe
>> device is disabled and NAPI is disabled (pci_disable_device and
>> napi_disable are called from tg3_io_error_detected). Then we can try to
>> disable PCIe link and napi_disable will be called again:
> Calling napi_disable() in case of teardown due to error and in
> ndo_stop is very common.
> So I imagine many drivers will encounter this same situation. I am not
> sure how real the NO_AER_DRIVER occurring situation is.
> If yes, then we need to fix more drivers?
>
>>    napi_disable+0x1b/0x1b0
>>    tg3_napi_disable+0x89/0xa0 [tg3]
>>    tg3_netif_stop+0x37/0xe3 [tg3]
>>    tg3_stop+0x30/0x160 [tg3]
>>    tg3_close+0x2a/0x60 [tg3]
>>    __dev_close_many+0xad/0x130
>>    dev_close_many+0xb2/0x190
>>    unregister_netdevice_many_notify+0x19d/0xa00
>>    unregister_netdevice_queue+0xf8/0x140
>>    unregister_netdev+0x1c/0x30
>>    tg3_remove_one+0xaa/0x150 [tg3]
>>    pci_device_remove+0x42/0xb0
>>    device_release_driver_internal+0x19c/0x200
>>    pci_stop_bus_device+0x85/0xb0
>>    pci_stop_bus_device+0x2c/0xb0
>>    pci_stop_bus_device+0x2c/0xb0
>>    pci_stop_and_remove_bus_device+0x12/0x20
>>    pciehp_unconfigure_device+0x9f/0x160
>>    pciehp_disable_slot+0x67/0x100
>>    pciehp_handle_presence_or_link_change+0x77/0x350
>>
>> This is not expected by napi_disable and a thread can be locked in
>> napi_disable forever. We have pcierr_recovery to cover a similar issue,
>> but for fatal errors. We cannot reuse this flag because it is reset in
>> tg3_io_resume, but it is not called when AER recovery fails.
>>
>> Similarly, if an AER error is reported and tg3_io_error_detected calls
>> pci_disable_device, a subsequent device removal via tg3_remove_one or
>> tg3_shutdown will call pci_disable_device again for the already-disabled
>> device.
> I believe the same argument is true here also..
> P.S: patches containing fixes should mention 'net' and should contain fixes tag

