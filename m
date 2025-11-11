Return-Path: <netdev+bounces-237668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E868C4E7A2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 217E64FB32D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8482BE7B8;
	Tue, 11 Nov 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c26yxBJa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xb+E2HGA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222C73AA188
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871010; cv=none; b=DA77if0VzuN4S/vYvM9qbuNKRfdJCQjkAqkBW0W6GirMy/i9X1bIuc2/8IFFN+QzEOaxcV72C6gmQKqo3PvgWmODrTD81zFuIXUuP4TWU4Zc3iazTckOZy9aF5dllLp1IYO6HEaiqeP36cLDg0xwYAh5tEBNxT7dWV9ka0lMwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871010; c=relaxed/simple;
	bh=Vy0OmFMi53dLcgS3CQNinqn3Z5XoaPVxq365z6ePH6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTINQJ1IbX84TSlXZgrX5zOXbTn8RZWysTlfj4hFzgCOlSUcfSJTGe1GG8ZdcdiwbmgHcgXAVAJ4feJJ3rDzLXfABq+NqZGLCexSIDtiDvVDSwlihZtyR4bejh837D2t/rHktERHjiaU5hW6tB4ag2CioZpvY2LEDjaNfOh7a3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c26yxBJa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xb+E2HGA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762871007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1TNEPTHK7KoofrD7uUNXza/INqoP0kMrctY+2+Od2U=;
	b=c26yxBJaqlzv3giMaiFcBpyZMvT2otAVNtRrwtVxDFgHJyNou5+d6xZ9YQFLGzy193xjmP
	ycUG71rsvYcqmSvmjvqwPTcKk1Rsdh3n3hk7RsByLSTFaCQfBY7A3yr6abpJs0oUbYuATj
	zV517P4V3kBUiRuyUBET7IW1+VxFia8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-VZkHbhGfNDilM7GjnyltUA-1; Tue, 11 Nov 2025 09:23:25 -0500
X-MC-Unique: VZkHbhGfNDilM7GjnyltUA-1
X-Mimecast-MFC-AGG-ID: VZkHbhGfNDilM7GjnyltUA_1762871004
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477171bbf51so27005675e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762871003; x=1763475803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1TNEPTHK7KoofrD7uUNXza/INqoP0kMrctY+2+Od2U=;
        b=Xb+E2HGAGHPNejD3Jz7rGnZ18Csj+qpdgFiZSCUFsqrmImpB3UjCxDfasf9XpdRL1d
         zUhxRDsfRI8UEcoMjX0GHnvjh9jk5mJXrrR/idPOv//z+V/4Dwxo53MabMAZWFhT/GGt
         1xLHWthsOcGVmYNuT/jsrO3u2zTZDvZzdoLrKugKIrPLw75VlWZMp7wUD8ZJ5wx5Rgdb
         EDGBLdcROwmjdumY97ecPB2qfxkAd/wOHrMWi3tVQpbr0ahCMMBYk26yZSQCeXLIdokP
         I6vxyIQExzlSL3Q+a/5URkfvvQ3Ob5I48XWqT43SCDAWvL+ZNFkOCgRQyyL/n55bdKbV
         zOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871003; x=1763475803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1TNEPTHK7KoofrD7uUNXza/INqoP0kMrctY+2+Od2U=;
        b=iHSS8YifUxKIDxSD+og/YYSi5BMF/dt94x6dUNaBkaWiRU/8ehb8c3JwXoU/80DSbT
         J+ao/2rgCahesESsUrNU1BBGfmo1k632NmPN9BDCRy0aAWXLjA03blsdI8gOr9eejFpF
         mCXwd8YOPboTEqfCfg6H2v0RS/ApVSVbPa5zqG5Pnsr7G53MjMvMYOP9aJWkoCn1ubBt
         Om7jRqKpVMbSrwHHxB4O6XCYDWnjcIxF4IYrnwYy7XbyYV+WegqgRWIaQBos6iaWWFSw
         kGt13hxWkS2dd9A8Jzk4B3VKqQ01Qyai+/bpgGmA96E6df2IQ3TI65KXs52DQNivGLVy
         XTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIJREYcvwOqnwC22F1pky79TnlVuF4qn8wjpR4z36McgF8eikrGhXOw+ia0v+4v9hd7zY+u/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlHMZZpziIno+W1Tcj0V5YEYsuIMzdQfNKu2fyTIpb7AVVNiJ
	sTokZ4kJDnf+R8aGv50+a1R29jSV+dbLay8uUpbqtrqKlnjOhGKs0UPV8n7EnSz3FNFuBxTesbz
	JRI4012ADvdL1KVRzt0y95wi0se41/4k/sQxvzMb0NvBq+2qXqAfvpSjHK5vJh2/IFg==
X-Gm-Gg: ASbGncu9yHaFgYNmanqoRbEf7pXbzAc23ju2oruQjKnqvCB10QRoanRQSbuwXPlJeSQ
	eXCrivsf7gOc92ba0YSbUt1GbRZnNVgNyN7xISjWgaPKlJgbkl+VDpLt2oJDNLxfzZptvrjY1Hh
	ePeXBnphn9d62Rg+OjVQK3fpFik4TxkpBpXOsJMFbW4jNe98VdQQ43/ur/aLn0K2iDlsjcOo9hM
	cROObXqLsGnZd4IzI0WO4ntZdY+LJYTTQ0jLp3B8jN0fT5gAGWSGz5sFc4j2MjodGuGFMyysTyX
	jBDXqgedwvmyilwJxLawqIzqhkm7evX4VWAduyrvy7SGrUlweHy2dVF8/4SmzPTb88ZyfvaovrQ
	NVw==
X-Received: by 2002:a05:600c:a44:b0:476:a25f:6a4d with SMTP id 5b1f17b1804b1-47773229f5emr94031345e9.1.1762871003459;
        Tue, 11 Nov 2025 06:23:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG77ZW6hMPrpzLJPsJneyExSs8DjfjSAnASd7fHJbg4vNF9ihDk0G27LfZe6cx7u3SpqR6DPQ==
X-Received: by 2002:a05:600c:a44:b0:476:a25f:6a4d with SMTP id 5b1f17b1804b1-47773229f5emr94031095e9.1.1762871003030;
        Tue, 11 Nov 2025 06:23:23 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477632bda1asm310765305e9.3.2025.11.11.06.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:23:22 -0800 (PST)
Message-ID: <6037c80a-ab5b-45ca-ae5a-31ded090e262@redhat.com>
Date: Tue, 11 Nov 2025 15:23:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 00/10] net: phy: Add support for fbnic PHY w/
 25G, 50G, and 100G support
To: Alexander Duyck <alexander.duyck@gmail.com>, kuba@kernel.org
Cc: kernel-team@meta.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, netdev@vger.kernel.org
References: <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/10/25 5:00 PM, Alexander Duyck wrote:
> To transition the fbnic driver to using the XPCS driver we need to address
> the fact that we need a representation for the FW managed PMA/PMD that is
> actually a SerDes PHY to handle link bouncing during link training.
> 
> This patch set first introduces the necessary bits to the 
> generic c45 driver code to enable it to read 25G, 50G, and 100G modes from 
> the PHY. After that we update the XPCS driver to to do the same.
> 
> The rest of this patch set enables the changes to fbnic to make use of these
> interfaces and expose a PMA/PMD that can provide a necessary link delay to 
> avoid link flapping in the event that a cable is disconnected and 
> reconnected, and to correctly provide the count for the link down events.
> 
> With this we have the basic groundwork laid as with this all the bits and 
> pieces are in place in terms of reading the configuration. The general plan for 
> follow-on patch sets is to start looking at enabling changing the configuration 
> in environments where that is supported.
> 
> v2: Added XPCS code to the patch set
>     Dropped code adding bits for extended ability registers
>     Switched from enabling code in generic c45 to enabling code in fbnic_phy.c
>     Fixed several bugs related to phy state machine and use of resume
>     Moved PHY assignment into ndo_init/uninit
>     Renamed fbnic_swmii.c to fbnic_mdio.c
> v3: Modified XPCS to have it read link from PMA instead of using a phydev
>     Fixed naming for PCS vs PMA for CTRL1 register speed bit values
>     Added logic to XPCS to get speed from PCS CTRL1 register
>     Swapped fbnic link delay timer from tracking training start to end
>     Dropped driver code for fbnic_phy.c and phydev code from patches
>     Updated patch naming to match expectations for PCS changes
>     Cleaned up dead code and defines from earlier versions

Not a real review, but on top of this series our CI reports most/all
fbnic H/W test failing with something alike:

Traceback (most recent call last):
   File
"/home/virtme/testing/wt-25/tools/testing/selftests/drivers/net/./xdp.py",
line 810, in <module>
     main()
   File
"/home/virtme/testing/wt-25/tools/testing/selftests/drivers/net/./xdp.py",
line 786, in main
     with NetDrvEpEnv(__file__) as cfg:
   File
"/home/virtme/testing/wt-25/tools/testing/selftests/drivers/net/lib/py/env.py",
line 59, in __enter__
     wait_file(f"/sys/class/net/{self.dev['ifname']}/carrier",
   File
"/home/virtme/testing/wt-25/tools/testing/selftests/net/lib/py/utils.py",
line 273, in wait_file
     raise TimeoutError("Wait for file contents failed", fname)
TimeoutError: [Errno Wait for file contents failed]
/sys/class/net/enp1s0/carrier
not ok 1 selftests: drivers/net: xdp.py # exit=1

even if I wild guess the root cause is the removal from the nipa tree of
"nipa: fbnic: link up on QEMU" (which IIRC is a local patch from Jakub
to make the tests happy with the nipa setup).

/P


