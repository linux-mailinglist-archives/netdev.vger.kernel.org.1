Return-Path: <netdev+bounces-254576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOOjNdPwemkiAAIAu9opvQ
	(envelope-from <netdev+bounces-254576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:32:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33308ABF10
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1913300CC12
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7452D6400;
	Thu, 29 Jan 2026 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqJFef6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14325332E
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664720; cv=none; b=AS9YMZoJ0VBxKqZOXSS1VVEZtnYwF0N9a+8e7UP0BQHgipPCOcXmbUNogr3RUr0tdJlLoqqPdL2djwIgIyOr5ZHbtgf1uLObTVdEqg//YcElbg8T6+V7m7KaK8E7fbktxkRYLmgzfqBRCnhsa6kwNOHxSRjtuIERtOWI0SYAlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664720; c=relaxed/simple;
	bh=kfC0kdXWn5sQttY8jrxWiZNTw1H6EwPxOhAr0fYXbfE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EhLnnuvvr1fqmNhzvouLGq4RPqOWPzXRHBKTnrj0aWSoD5ID7qJCq3/5dZG32mshFnXQiudtumz5m6SV5phVd+dWSrYpIa8EcNAI4Is96G2cMWCqAn17Lr6OYon9IC9uhLgidCa952rkgtM8W20n+7GQk9iLrILKoOMMWj30bvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqJFef6Y; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79088484065so5242917b3.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769664718; x=1770269518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyFYopJIhzzdTTkJutxVCxpbwQZKTlhFSJb9wCVy7us=;
        b=EqJFef6YsKGxaOZ2x9vNX/h3BKkrgDZx1QhOIVQCxkNW8YVBR8vOMkG1RgKvTiM1/h
         AvbWRTUg0a6N5O/SWR8DuN0z8DFCheBlPxdUW7fjMEJyAWb1uRaNWTONzpE1GfDFLveI
         Ws7WAWtPasGgkSfFUiw/X/Z0+ooR5Wa5Bf94vlL6InbY3KPUhJWYqJEvyEpaFlFQ5pSL
         OOGjp71ZXTber0UbMqcQBgQboa5faO1TCD/6tUxCEi/ll2veEnhb7is/BH0BtmFo3F3f
         ogaGM9QS6xENSRwmXZoyKC8rofHVbY/rESj4dDcBEVZiV7X23xR7A1r2EhuM54Y0i0W/
         ao5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769664718; x=1770269518;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CyFYopJIhzzdTTkJutxVCxpbwQZKTlhFSJb9wCVy7us=;
        b=lZmSfSxcu2EUIxbB5Jul2CvKeVC5n8c5Ytj1vEDQmtPlAvT+5oJ+fxWRjA3+kgT1XD
         Jmt37lDbaliW4NMhpfsqktOZKCFPheHrPFVpXVEbEgcqGBxeMhuYYcPvJBT29u9biv0Z
         Q9QdJMO1Cq8op/i59pVrxJjiTYrePAKRF68iLhAMnxfBlFNVpfpWxrYnZu6fM8hxZtJF
         8dqiCPya6LZj5SB081F5R12v6+98N0xwtXWG8n9w5a2NBqksdnN8mxFkZ945i1YA9C1B
         05VW8fycpICcVbmiyah4wFPl55cPX0QjQW4SCDuQuMaYG9qm5ayR+uIFdcELppZSvJHv
         CQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCWebxG6Edgfk/Xyp22jU6/mW097njSYiU3TmSrX7w6pVLmMxbpD2ufF6JHC9BEqndqazgkeYNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpc2e6a/KDmGside32rqizDLGtoqKQD9Xdlt6pwpT1ssi03mdP
	pg0ZqfvpSCRwk/wO7zqnJdl5YsuMc8BqVLF5KiL3kDX8H4fa0gUvmEhOFe8xnw==
X-Gm-Gg: AZuq6aK7sJRfAwvJ0xGuaO/5PnXA6pLoe7Fd+wrk9wpW4GP4d+iwPPmEe/lCTZKZgXu
	pJs+pPTXPTdf+mrPjh7shheLvw3cZBjaBewaJAZiCQR17MKZTl/GgcxJzcwhwvDFQakrz1++hnb
	EdfYchJk/nmohiRXtFtC6Ji/PmEiN9NrUlBQ/YnDb/kuOdOT0YVLuWU/QC7Cs0zV+PFP7Kbb3fc
	xGf6MpDALPc2tQUU9A+nJB6Zy9cuK3qvQGWuzTrzz4cBA6zIv8xw02WU82XMQXUE7WxL2DNLm4P
	aiqOhzQXABd2d7/kp4oelroNYOunrmhQoLU25nOKkE+eZyuQTRk3MmjbJ0kIUVF375E0Nr9fWYV
	Tlov6yYIUPdzAMuVcCsrn1lrk/QMAKO3Nc2mkYIKQ2XNPBNaGeXIhum//WCgQ7mcWPl23baYpmQ
	DRxEMplP7HK35moMEtt5yAk5P+HNJmhCFHqYMbn/JIg0+G1ayTl0jnahq5FT4=
X-Received: by 2002:a05:690c:e3ec:b0:794:7e1e:7f3c with SMTP id 00721157ae682-7947e1e8dc5mr133461397b3.62.1769664717837;
        Wed, 28 Jan 2026 21:31:57 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-649960788bbsm1903637d50.9.2026.01.28.21.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:31:57 -0800 (PST)
Date: Thu, 29 Jan 2026 00:31:56 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 netdev@vger.kernel.org, 
 justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <willemdebruijn.kernel.343fc272aec2d@gmail.com>
In-Reply-To: <20260126194826.236075-4-tom@herbertland.com>
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-4-tom@herbertland.com>
Subject: Re: [PATCH net-next v5 3/7] ipv6: Add case for
 IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254576-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 33308ABF10
X-Rspamd-Action: no action

Tom Herbert wrote:
> IPV6_TLV_TNL_ENCAP_LIMIT is a recognized Destination option that is
> processed in ip_tunnel.c. Add a case for it in the switch in
> ip6_parse_tlv so that it is recognized as a known option.
> 
> Also remove the unlikely around the check for max_count < 0 since the
> default limits for HBH and Destination options can be less than zero.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com> 

