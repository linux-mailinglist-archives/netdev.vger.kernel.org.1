Return-Path: <netdev+bounces-277987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NtkOBKr3GlfVAkAu9opvQ
	(envelope-from <netdev+bounces-277987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:36:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 570653E930D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4877F300CFC2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618E3A6F02;
	Mon, 13 Apr 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JJ4zPFvI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A83A9D85
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069390; cv=none; b=FkZc2RU/CFr4iQr67ZTXbW5wYexKe3N363XBEhc/BC03A6MnvfgVAmeqM9yIgGJw2feBDJuyZzFSBu9uAgJLyJDh/oQyFeBAkdSHnxfFfPaBHBzGF80ZwgN7zUgR706xjSHtPiwF0+ruCoqp6SIB0Z43QJJj9PPp7Lr9yeVaSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069390; c=relaxed/simple;
	bh=nIKY431RfJGmjy1wUPAZqvNxs88uGqMwZodeeQhUTP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8rCgoARYQ2uMd1Ku35eL2M1jWpyyS6IMuPhvlk1yE6ecwYS6B1seE/X72jDit6VsZreLtWwPzYgZPt9E+uInHti/oDIH9+HaaVYdJ9XPhaV0rdXb1wRwXp1GoIWclCjEIvxzlGLMcM7BYAL3CuX/pJreswBYMactfvsCQptu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JJ4zPFvI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfd832155so2742493f8f.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776069387; x=1776674187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t4iEtYb144WUkeF3avCGkP+wtgzyfR1UboPNXWxw2Zw=;
        b=JJ4zPFvI1LIQjzG+ig2YhTva8RLk+fUvoTJb6pkVp9q0+v2Srtt3+EmcGSabreRo94
         qRescRHHRAM0Ady3gW3INGWH1At7g7XQqQs2eaH7urImNXgQ1bLzDzdqhASyQeFe+T7w
         EuO3WkdkEXkRnPIm27M4jSSHK4LPoGQaMIm+QaBqZXyWsdITAj+gYQTXJfxMkiv1d9Vv
         sUe4kAfh2YFqUkTEI/Gd/PHokwF3NgUX1IKfE823uSbUcEMhG4HE2c3lG8HMupoGYui9
         VeTf/RsePOMgHI08CiFGpSK40i3us90hry09mHT/yn5LASppPiTHdrT2IY/oTPn/3bNw
         RlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776069387; x=1776674187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4iEtYb144WUkeF3avCGkP+wtgzyfR1UboPNXWxw2Zw=;
        b=kRLtZrcOoSjQY6FzoAKt9fRyzDml6HGN8LHYIrJ0dBgKZxaf3hRmJqJwB3rvN0BeER
         3VZMZ0lIfagZD2SpUftaf0EIcQ6Ys66MKOm2n2H0z2sBAfzzB5HI+4zk7rsswTIjjl8j
         9qdDW0FEURcJTK5S1BY+9aQ61TkVeQyYLBUDoBP92q3min08kJiIKbHWvIE+v9J6oMk3
         2rXHojg037Xy3d+qNQSqeGtbPez3VgaYgb8fPhDw2iYbeOmiZuTlCttfarJGiMOUuVnV
         nF8iGK8j5c1U9qa4Ow2/TqewphiET0R/6eb4JCq3pERxS8lpxPhTS83/mYuc/Ew1gSHJ
         lfHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zHjHEUoYTTDQWsqStGA3n7NzhhYUdMMbOb7Dtwzp4nDSFmQKkDHZ0IZmUK++kJ556A05MTSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZISfF64K2AMJJ3YqNSfCOELs/JlKZYyXxZ8ntYVUy4gP5RV2F
	hwrW7HXRNHw54K32f98sFzWZoRonxd2xxRl41gGQtq5VM+jNlKo5AoXt7xBDTm/g+BY=
X-Gm-Gg: AeBDievQTj4dQlqpObi8h+iSaSj+47/tdSDnM2KqG/RP9EhPKQWfsCqOSBAG/kAbufR
	FfkMETfWB7R76tTa37QKHZAXWVg8lbOw5FLpX+5/Cbbqkaj6oGgmEPG4oqaG1unpJbsHk7ioo1P
	m/2vtAV+qo9dCxtuqiPLFUnJEcxhITm/92cRlpXNR3tv97iEVLZk/u0pyW9/vY7sIapa/vjC0Iq
	5WlksysKgRgiZnZwrb+PpsGWLONqKAJFN9wbIGxKouMH1QSDL+4U/0e4Z5jbKJbmXwVK+jmsjVu
	7NaJalTfn9Kxgdk99VWH/uJG6sBsGJEcwdAvJ1QVOIF2B9JOankEuOAxdyo4O77w5jJC1pnQmQI
	YILhEkknM5O03hEq+FImmES5bvE16K5iv7/1tN+yGaj9rTPNeqhUuc4p5XYLQNhRHslikeYm9Ni
	cxpH1aH7XQ4G7xVEvBNABNRbi9mgomJK53nERgTv+B6RWU6qqd9OlgbwQpTtN9NnrMrvN9FxHdb
	/pV
X-Received: by 2002:a5d:5f92:0:b0:43b:60f7:2283 with SMTP id ffacd0b85a97d-43d64289753mr17732019f8f.22.1776069387432;
        Mon, 13 Apr 2026 01:36:27 -0700 (PDT)
Received: from ?IPV6:2001:a61:1301:4901:b3c3:e8ee:625f:648c? ([2001:a61:1301:4901:b3c3:e8ee:625f:648c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46713sm32071248f8f.21.2026.04.13.01.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 01:36:27 -0700 (PDT)
Message-ID: <2a6963c8-4a87-4fed-b875-d46f3ce53e42@suse.com>
Date: Mon, 13 Apr 2026 10:36:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: usb: cdc_ncm: reject negative chained NDP
 offsets
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 stable <stable@kernel.org>
References: <2026041137-comfy-eaten-a1ed@gregkh>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2026041137-comfy-eaten-a1ed@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[suse.com:server fail,tor.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-277987-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 570653E930D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 11.04.26 12:53, Greg Kroah-Hartman wrote:
> cdc_ncm_rx_fixup() reads dwNextNdpIndex from each NDP32 to chain to the
> next one.  The 32-bit value from the device is stored into the signed
> int ndpoffset so that means values with the high bit set become

Well, then isn't the problem rather that you should not store an
unsigned value in a signed variable?

	Regards
		Oliver


