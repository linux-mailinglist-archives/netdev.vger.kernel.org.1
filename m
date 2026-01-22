Return-Path: <netdev+bounces-252254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOsfGC3ycWmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:47:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F964C34
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E80B82A56D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E95327C09;
	Thu, 22 Jan 2026 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmj7s4uT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15833DEF6
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074794; cv=none; b=XIR8I+QW9qGPi+a2Zf9ISEgnYRaJJYM+myxHHyMq4DWcrLSaz1bXHU2veaqa6Y+wH+qo9utGqJYpwxrtRAfB2Car0vB+i7pEiqoUvXyrT5hLGXQufK8gVfPN78r90Cx2qotkZ30KJL3IotcuMEjV+PsUayU4JJX6d2tdqKGZpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074794; c=relaxed/simple;
	bh=SNxYqgjmt+2t21e3gRjMkwbD2GCI9ezskil2b/YbjFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFRVnVgvo/k5/G6O/5u9iITWCQacqhCdl3L+10bufimKhmhbeRhX01tB1/Bxo8EqGdOGBx9az0KDDkT1qoM7SG81bkwvXzGlERgBbJei0cBVSoXmRwSQRbzeNBPMQha+0zmt26Cs3lH0n0CWFQBv72dRvpGOAbfRSpiqjNMQMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmj7s4uT; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12332910300so239226c88.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769074791; x=1769679591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC6SH53RK9tBd5Fp7gIiY7yZ4DLB1JMDI6tC+GGvcN0=;
        b=dmj7s4uTez4ahMIHnQ5LXKEjlIou1hkU+plEdDxPjqjcPG88rDh9afKjkhqBhzP3xj
         StNKOBEL08ftK9l+mcCyIj8p/q0qO7rduGWNmdeXZXCL//GETbMVeNbQFMTyCVJ9xmwF
         93FIN98gBxQSzq3YKxhjib/6j4hnHlR+9ofUiUIMnO4s/yznAeuPCakOFI4CPH4DCuoJ
         HaR9VZ6OLAIXeOAKyTQbWTKs6dIbuPiSRqLOUCX048Zj6eAAwyvjvu8T8qlSlht8qdKF
         n9yM8eU3vU4nXUBkGrAGHtk+as39K05aDAD++pxwFjJc1uuLNZeBZb45/yKeOiNHqQX9
         +ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769074791; x=1769679591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EC6SH53RK9tBd5Fp7gIiY7yZ4DLB1JMDI6tC+GGvcN0=;
        b=QGUpa7vXkKoteTci0B3raezv/A8ceP1v6RBvpRr19slG99gfeb2VnUFnJZuT5cr1xf
         KeFAdWoAvn3MCi/BiKb5tXv6NpRMj5OVZI1tRA1+4l3Gb+zkNn3XEBxw24srJExppdkm
         MlMfi12256HvW/VcK9/OnBgij8mLqpHV4LtWBuSfCKSzVFFWFVuIzIDODJbwR6PU9XiL
         5k125Z0dJHpDDHb0nXVKf2pigE0PNx47vp7wNzKPX2IoLPW2HD51KxhN4a8aWaTAqxZa
         JI1zFoOOvKO+Zqa7E1/ayQ7TImgvf7CdhwMrQgTVSuSg9AYs/9jS8wifoUjGOEA+VbMS
         Lg4A==
X-Forwarded-Encrypted: i=1; AJvYcCW0PQcPe1gvAeMO7yyY3zoOLLU2bDiwn/Qc+OWygir1+FncjaqjOkY98DCSEdtIhfOS+cNDTig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvYca1pPJujITbXkpUNMYRbWv3dYmKEJbsH/ZmTaj/SC6yCsK
	Lu/pr3oJdfTQ/Qs7l84oystaMn8/D7yfFHvFN415TYhtuybbbVOeIhZN
X-Gm-Gg: AZuq6aILPCSWh4DO/v++BnQirPvr9fh2MXWtdQqZ716+nUtvfpc+ADakjA2fFPRSqVb
	bchpvwyxpi6N0yOB1qXbhGFfeJSDxIEtoyUAlSDDhDG2uOAdVPzcaf/Aqv4X13jZHIqHwD9c8GP
	J+pvi06Nhh+Q/9WRS6GyEeuDXglO/+JyeNWJtTaNMnkkv6nM+CKIqyAomHjwo5ZPQQsxbXi5DTg
	STxC+T4oq/ujJmuRvgnQeMiyl3hxSbScbhH+ZbGfzOPzJx+GW49/rKBCFwkkmDDtvxudXidAc3w
	WnO5DU/apVGYWd57CP88vLFEuTZfBGOPiRD3nYF/qAYL3xV23hZOuNsExxIn6p9D8wrsXZKoRDR
	4yMPi5xxN1+mgaECfwHrvAKL3iklyQAo/Kx4KJCAQS9x4kW9nMXnv9wzgv0fRSlE=
X-Received: by 2002:a05:7022:4586:b0:122:9d:bd43 with SMTP id a92af1059eb24-1244a70cd2bmr17402148c88.19.1769074791226;
        Thu, 22 Jan 2026 01:39:51 -0800 (PST)
Received: from gmail.com ([2a09:bac5:1f0e:28::4:33f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac57fd0sm28473087c88.3.2026.01.22.01.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 01:39:50 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Chuanhong Guo <gch981213@gmail.com>
Subject: Re: [PATCH iwl-next v1] ixgbe: fix type punning in ixgbe_update_flash_X550
Date: Thu, 22 Jan 2026 17:39:33 +0800
Message-ID: <20260122093940.213113-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122085102.1117651-1-aleksandr.loktionov@intel.com>
References: <20260122085102.1117651-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-252254-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: CB1F964C34
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 09:51:02 +0100, Aleksandr Loktionov wrote:
> Add a u32 buffer array member to union ixgbe_hic_hdr2 and use it
> directly instead of casting the union address to u32 pointer. This
> avoids potential strict aliasing violations and makes the code more
> explicit about the buffer usage.
> 
> The ixgbe_host_interface_command function expects a void* buffer, so
> providing a proper u32 array member in the union is the correct
> approach rather than relying on pointer casting. This eliminates the
> type punning issue where we were casting the union pointer to u32*.
> 
> By using buffer.buf instead of &buffer, we pass the address of the
> u32 array directly, which is semantically correct and avoids any
> potential undefined behavior from strict aliasing rule violations.

This commit message is unnecessarily verbose, looks like AI-generated.
The kernel is built with -fno-strict-aliasing, so it's okay to not
follow the rule.
What you're fixing is likely an alignment issue. (see below)

> 
> Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index 61f2ef6..eb5bf3b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -2798,6 +2798,7 @@ struct ixgbe_hic_hdr2_rsp {
>  };
>  
>  union ixgbe_hic_hdr2 {
> +	u32 buf[1];

The alignment of this union was 1 byte. By adding a u32 member, you're
effectively making it align to u32 (4 bytes).

>  	struct ixgbe_hic_hdr2_req req;
>  	struct ixgbe_hic_hdr2_rsp rsp;
>  };
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> index 76d2fa3..4a0ccbf 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> @@ -1228,7 +1228,7 @@ static int ixgbe_update_flash_X550(struct ixgbe_hw *hw)
>  	buffer.req.buf_lenl = FW_SHADOW_RAM_DUMP_LEN;
>  	buffer.req.checksum = FW_DEFAULT_CHECKSUM;
>  
> -	status = ixgbe_host_interface_command(hw, &buffer, sizeof(buffer),
> +	status = ixgbe_host_interface_command(hw, buffer.buf, sizeof(buffer),
>  					      IXGBE_HI_COMMAND_TIMEOUT, false);

`buffer` is a local variable allocated on stack, and the compiler did
not guarantee its alignment. As ixgbe_host_interface_command() casts
`buffer` to a u32 array, this may cause an unaligned-access exception
on some arch.

For your reference, I addressed a similar issue previously:
https://lore.kernel.org/all/20230601015432.159066-1-dqfext@gmail.com/

Please update your message, and try not to use completely-AIGC phrases.

>  	return status;
>  }
> -- 
> 2.52.0
> 
> 

Regards,
Qingfang

