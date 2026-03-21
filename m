Return-Path: <netdev+bounces-270231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIgBOqTDvmkKawMAu9opvQ
	(envelope-from <netdev+bounces-270231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 17:13:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 445602E648C
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 17:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E830F300A8E5
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E932741B6;
	Sat, 21 Mar 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8F2m3vM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A82EACF2
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774109602; cv=none; b=KSAnNMU5T6gQpasEPT7n3TL2SV9I8hUHzXZsPbQJ32TbgW+etFODEOoS9xA13YLk04VPNR/E6XJH1aI/Tq07FnkPSuTPIO8VFICrRmJCZh6OWS6GmaObRC9BifMJ8F2krR0fX/iVmy/xuw8M5T0qzQ/wzzA90G4vYIZ5SD95YXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774109602; c=relaxed/simple;
	bh=mNNUOSElE93XBNVLKuerwZf1NZ8TdHEFY0Y1DjQR4wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBjh9LAIyMx5vD8keCYkBZ1T6Q8VboCXICI+GRSyzEHS5gE27mINOImeUDx+BilMxZHucLDfmJEn3X+UFgxS5M5l44AJLtoEhSqNn4MPnSGcrBq6X8mZe5/AjR3lekRXtuwf+yFB/XV5QTVnDzkhPOWEZM2Vq6UksSobZsFLUSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8F2m3vM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso23270155e9.3
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774109600; x=1774714400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7IfVO3dcm2urTUZHlWQveb5Lw9gItglZSCTypGOlDk=;
        b=D8F2m3vMih/OChUMzLUjyK+OfBiTxmkwSWnUrBI5fLppXdI/CrJGP9J/6NTXOf9QwO
         e+PqZo9wFUbfoiYh1c3URfbUAxfYbdhaxLCj0Zb6PkL7CE38kdWuYEGRERt+bKaOT5vo
         A70ieqvcg1z8wNIcqcZrQeECY3FAZb1xjtQn5K9tlz8lGmRa8Or+sRK6pCVRAuYEsQi6
         23i8ec19hy1Miw1tRQb28DuKwKgHNM/bzq+2+LlLjb8Odv7Ej8+6g80dLyVaLU2XcRZ5
         3qoO92ioKPMAdmkm7nOkWjHp/t8JELwpRC/xTE1Q2dmNvlCYwDsSgJaLJWQeiEIrBLby
         HI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774109600; x=1774714400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7IfVO3dcm2urTUZHlWQveb5Lw9gItglZSCTypGOlDk=;
        b=dEaSP2SAx3yX/qqUcp3H3RO3OsIefsaWdazH6RvhZ1NK0PA46hhYW+6gRYLHeqSMyF
         dHoJnYL7Lk5k5ggyRrE/LsTFLwhFHSPz9MP+vLBUdo6lXj7f1BknL+0lMIYkd+gyqNpH
         LxKx/VmjvMUBLEZhc6SRUpLZU/wg9jklCQsDsDiwVTNCiZt9JuJz6tHhCX+Eln1RKsNY
         4+6Ev64JOY/P5pFPfQLoSTAWb9JL3Qid9uGXyRfGmBIkJSB482jjPJ5s91B/drR3pQHn
         soxZRajoW8/w7dPaPSa/wfuF0yjaBxcf4H03I4fLbmt7o9LZdybmADo464UWtmBFFz98
         cmMw==
X-Forwarded-Encrypted: i=1; AJvYcCX7EHOG2nf+fZ897LocwZ46bAKwABCbfOHeIMG+LnLWaLisXr/5Gtp689a4GVss9Gzv4/ICn/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfty/HyW8AGDxxCT75075mx3TLlpWx0iMADG4x+45VxCWEAW/t
	oTK7bxfnMBfjnPKsifyQjvHjtv50TkvmQ6W8Vu3p4znnh7KSukmd3t3W
X-Gm-Gg: ATEYQzw2uUxsieL3n4CIfnVSOjWzRXSap5yHBrnKpi5xH2t/1UQ1M81BRFNXZpH5ZMK
	5sprTyYxY2ayzyOf2vJ8u+MTurty4kyEVjX5p2uptIDSpE/q83a9lug2sHrzwSpsVeMcUvsk8nA
	KXmSMV6wic7b8OLy1Rlo1uIihTt1IoTMxFYRlU3PNA4dxLH9VTCRaML9qDtRto97aAuW2rs9a07
	1zxRkVgtlq2aXxGeesD7wdv0040wwhV3Zn/Wm5NKMY46geWyIgttcoA1p9M9YPlzjt1mWbDS+WV
	I4FqDyGcQAxuhOEUnYdEgoTyyueCUjcdYRt6uJZheNWlhcOS8ukO3dREiEGf4KrNsRfp4vH7vQL
	F0AxVlgrp146/UsPGhEzcqjfyQX6amvd341mEJdWVv/SKpUl1s3F3c83x/ZpRypSuyuIyigu+oP
	cYoDqa7oYYeVCVhejONU5IN0sxuR27Bm+mu3+9sQ==
X-Received: by 2002:a05:600c:3514:b0:483:a27e:6706 with SMTP id 5b1f17b1804b1-486fedb54cdmr95172105e9.9.1774109599452;
        Sat, 21 Mar 2026 09:13:19 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe82a030sm157599935e9.10.2026.03.21.09.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 09:13:18 -0700 (PDT)
Message-ID: <4b8a5902-9457-42a4-bf0f-96d6e5ef73a5@gmail.com>
Date: Sat, 21 Mar 2026 18:13:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] rtnetlink: count
 IFLA_PARENT_DEV_{NAME,BUS_NAME} in if_nlmsg_size
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
References: <cover.1773919462.git.sd@queasysnail.net>
 <0b849da95562af45487080528d60f578636aba5c.1773919462.git.sd@queasysnail.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <0b849da95562af45487080528d60f578636aba5c.1773919462.git.sd@queasysnail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270231-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryazanovsa@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 445602E648C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 01:02, Sabrina Dubroca wrote:
> Commit 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
> added those attributes to rtnl_fill_ifinfo, but forgot to extend
> if_nlmsg_size.
> 
> Fixes: 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

