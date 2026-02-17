Return-Path: <netdev+bounces-259086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BOvIXSTlGl3FgIAu9opvQ
	(envelope-from <netdev+bounces-259086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:12:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00AD14DEF3
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83DA0300AEE3
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857036E462;
	Tue, 17 Feb 2026 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nIdHg5XN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E736C5AB
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344753; cv=none; b=Sh0x9PVxHLbeoCaDxoedqRcjpDM1cYv+ddZdfWX3OIovcGkizVm2cEhcvOWKZdwNtIhrOMze0IMVEYIUr+6Y6Bh4tiUxBcMoiNod/BU/VcW/3eIe4icGYW/l+6fB4tcCTmViGYiVPElH1brhXMb2awYjVJF/KEBJmXrO1lrqeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344753; c=relaxed/simple;
	bh=MqxZpUyalWDJNzgo0WngMxHy4eila5HL5zvFR6EvPR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcQdkNoN/Ufdj2zaJrvDCs+NGE4CP1dgVPiSIKDUPMIjum7oI8VaBo6g8VcmhQ2y8lcJO/S2jPvMZ05tf/3mDVSP9Qkyoq/gKuv2rvQmL9hofsHNdOfFp5D31zPRqi5CyDWETDRxpzPHBCXQ1dZ7h2S+fNJ0j++8mLloEfgHJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nIdHg5XN; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-463a0e14b4dso890991b6e.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771344750; x=1771949550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2/5jAjNDtEUE5MD+TZFaHYaNQZZv4r4j1SEEXToQXQ=;
        b=nIdHg5XNwyNwaG1cpQnqF+h2fr3XwOdkIygET+QSYTxAjWHEqwE9s6aeoPjS2pT7Mj
         BS4SKJSPpaxXQwKgTzFVcEKTv2beBTZMKJSFnOqV2bLKWDmZztuWPGRGZa67A78T0fzk
         qRCe7TmdLWu0t+806NP3wOPG4rDiOoLO4aKl8qwkoBuqhjfMaG0IQLHO3R4c8DCWMSA0
         A/HJZDC5sJi34t/c6TUbLEg7TCbzaC9tAdeB8UGCRyuG1yHQqqVuCPidzWHdmmkNSs6M
         LtSV3VocfPZk/l2NrNBzG2v7Nj0pmtWWdwtPJmB8wmQpKpzZm2LvIRkhFrDttI1YbLZ2
         XHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771344750; x=1771949550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2/5jAjNDtEUE5MD+TZFaHYaNQZZv4r4j1SEEXToQXQ=;
        b=FCqDqCSG0XdeCFZNpcG5e6s0BPbcHiTEJ+Sy7Sg20smX2ea607n8tg5lxQ9FaYJQmZ
         JV2nRXSccCfFwHHr8n7B9SYVFDyTZaufxQuDdFuohX6YgziVBFLH+o1F4JIvZSso8o/b
         q90fxMWxMl897idMwa63+WUZvVTLtQsugzqV2SVWT88gOz5xi4deSHs2RGLBGqPR6v9o
         DKSEqYW7yzirmKrfRnvoFe9n8xNObP+BNIErxsmMx8g4EyqciUAKCKRkpGJBYR9bmvbJ
         EBUNvevjddx6+qqWdM76yDNyYLoqYIwBQTk/XqVFQ7p5bd4qAUwDxHW26DU9YD4uGLXs
         TaGA==
X-Gm-Message-State: AOJu0YzjKawI1F8MbIC1u3Ejfl432MKlvzp1D6C6357xpQY5bhT2YCfQ
	+X4md7PNbUZJjXuv/ZzgqOFYQKePr7sx1l47GqYv9HyZ5XGS4rxKHHS+LNNbR/bkhEQ=
X-Gm-Gg: AZuq6aJSFJM2nkUtVQuQ7aozq8UXifoN7jEE27AlaeKlp1FuozbcZ2dG3f7QR5sWxnl
	8DuFxdWMRAZZXT3eqVbQ1Lqs/0NBuyrxs4eYJZw+WuXkyuhQ6EBNGZ5yJ+F3OV5JpFvM6wzAllr
	cHCIjMCXOYy2i4f60XzNHybjnb/wXEsfKdcI8EMqzCjICsHOHn+6oJtfUMkiMi4MQuxQDytbcLc
	MiOFFrizneouquHJTjIxI1unEedQs2+T6JW5eNPC1R3MSrPWU5Iwh6Abb37Dj/PFtwo3Wlh/25G
	+PIFPQQwxp88AhWl9U+jkSTgqRF32qMYr9/jEKrzOdbpEiVayNIkI0FZkfvML6Y2R2Afb6hiugf
	3977rgI5isqQWHHOwMfokWzrOcKDAgdH+Bt798yaM/M50aVNMTsU5dRf5XYYITEcb9tpGZAKtiP
	xPvVSCQsL/V748D3TjOWYszVtELgsuBdmNojsCV6xNbFEy8EtiCZMMT9DYLnSJBSh9EsAWJ2rR9
	RJDuVL/wQ==
X-Received: by 2002:a05:6808:158a:b0:462:de55:9d40 with SMTP id 5614622812f47-4639eedbcfamr5290811b6e.3.1771344750493;
        Tue, 17 Feb 2026 08:12:30 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-463ee1f67f7sm2775988b6e.12.2026.02.17.08.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 08:12:29 -0800 (PST)
Message-ID: <9289e38c-1528-4029-a278-bceba6607697@kernel.dk>
Date: Tue, 17 Feb 2026 09:12:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC io_uring review-only 0/4] zcrx mapping cleanups and
 device-less instances
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <cover.1771325198.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1771325198.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259086-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: F00AD14DEF3
X-Rspamd-Action: no action

On 2/17/26 3:58 AM, Pavel Begunkov wrote:
> First two patches move user memory DMA map creation to an earlier point,
> which makes it more uniform among different memory types and easier to
> manage. Patches 3 and 4 introduce device-less zcrx instances
> for testing purposes, which always copy data via the fallback path.
> 
> note, based on two other recently sent patches splitting out a uapi
> file and defining constants in zcrx.h

All look good to me.

-- 
Jens Axboe


