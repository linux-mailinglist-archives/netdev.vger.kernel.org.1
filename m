Return-Path: <netdev+bounces-271981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEjRNdoRxWkI6AQAu9opvQ
	(envelope-from <netdev+bounces-271981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:00:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34BA333EAD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2213131881BE
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFA73E4C7C;
	Thu, 26 Mar 2026 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hs6kl9HW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qWVotACq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C13E3D80
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522087; cv=none; b=NRb0M1kXLUAneNv+KsrJWYJKA660Z9c2WlobwyrshFgvMhAS/WR08r2zGTzstzptTdldjXLhb0QNDZmFWxsdXBM9P0xBbk7No8qf/Eoh+BYU6VUGIr7UaqD0wpFbSleC+3/nuEFOosYvODoIis4/2Me6FHdM+pZ2j5Q5DsqgSI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522087; c=relaxed/simple;
	bh=uIcRW3F8SaRvIJDZPqw8GyIEkhv2qqW+v38gA48RCtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQ+TDVHR+zUhGF9UVjTEpW69ihScs80zwJgCs5/4f3C2Md4mon9vl53zSTxzt7Z3dURev6GRs/KqVZAehhlut5uysjNPCNmACnQyeek3PQRwJzQM7yV0evsr/0eoT9+BET0it0O6pNbVDnCSdSLbg7m1qOxQmrx6H8uCxKo8b2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hs6kl9HW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qWVotACq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAqmLcqBurjjp0ibi2uwhQMZrLCiAudEnAKz8jekrCE=;
	b=Hs6kl9HWwORQ1IQ1dhmsZYi8fTqDNSknnA2mITYBehynxPQ0BFNCXNx91ujnagssJaRjHF
	HMBtecPTNkY6OJmqjHnLyz+cC3htJMHbyl1lDRvf6S5tUfmPHEZGFmBNCLWtwr8OBlqjMB
	0NCdQ+upBn2+mKJHsFMoP8gMw/PtN3I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-D3nQ16YPPvW7uQHRNls41g-1; Thu, 26 Mar 2026 06:48:03 -0400
X-MC-Unique: D3nQ16YPPvW7uQHRNls41g-1
X-Mimecast-MFC-AGG-ID: D3nQ16YPPvW7uQHRNls41g_1774522082
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b7ec737c1so524630f8f.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774522082; x=1775126882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAqmLcqBurjjp0ibi2uwhQMZrLCiAudEnAKz8jekrCE=;
        b=qWVotACqroRJDuKQ9pkMhLRvbeXTGAMoExzLJR9gapuvVz+bPvAHlOxiFJqPJjO1p3
         YaYcfxgTVncKZjOr42H/dQHTMavzeHoFKGHC2JTewfdY8CVI7fDxJ5meTEl8P7OONYJ/
         Ca4YglZv/uimaeIz8i4YwusXBI4c0Auo2Ntelhj278z5Z1YbWMAw+wvY6kh1GPZQ/ylW
         N3R3Oo0ZhdvWI8dumiRzZj2ldn+sstnJlMYsHMWhzdSWOSa9tbnGFGoURW12sBvM5U1a
         QJe1F1l8MlYSclXmC/i6aQZnjvH2IVIc/5CKkXe3abhp/uDbuPst1qmesf8pBGYVzuUz
         PO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774522082; x=1775126882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAqmLcqBurjjp0ibi2uwhQMZrLCiAudEnAKz8jekrCE=;
        b=C5QLxOp2R2yebxeywE0XAr4pmf5g64Qm/2zgCT4xw65g6fj/jg2dxp1Yjq0pzFSr6d
         QFAK5iAT9d7Mthfxl95KmY76r4JBXGnPpdmwPJdwvdN6Br2HIoWzTzSpV6vJOhqfn5Ut
         NHll44WUaskKJD4dUe7mKEkP9WeWC4bi9DDOac7Q9M+yE8pQSYmX9MkhCU7OGZ2zNDqj
         FcNIw1LMZey54Ee6d8lf+eCRZ4Arf5uRdIOxMsGb1T4wsp/y/HJgI42XyuOQwoRcMmE6
         F6j5XZylmaIEdqdB4TSOq3OcTPvTUjrN5UEooewvjj0tTYJ87s1CAchltj4fqChYmAD/
         hz3w==
X-Forwarded-Encrypted: i=1; AJvYcCW6aB0waQ1n0Za0vF25DCJDnhW9wr5ZudbbXAkIP9+Ij7CKcvX5thf1uURPTzW40ip9yEAOEFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9teDfI2zpffE7osDXUuB/WZCEmZQ6ThjCkKxsIbHfwn72sSMa
	rwCwqTJmyBq7QFrHufdHV8ZD0Ap4XKiGRtcxKxsYOC8I28DvQZuVLGKpYb90DlKPjOTjDDWbe8r
	7lV7/yeiCFbCvY/a1rIM3DAdgzhScps8tgkCz9DQ97NlUOxgsdNme+WVWMZBGjOBtkA==
X-Gm-Gg: ATEYQzyeEJzFnJ2dFAEyocT0yNf3AkSMzw5+CAeOvNCK4nFnMUtYCX58ursgyG/GSt9
	wr8V4iIEjS89qdkl0sSFaCcGJOyL3BWGfT/XTZfW51N3LhtgVLvPxUGvuGPtE+ihiPDKW0Emez6
	+s7b4k1yINlC1sZzT2ecn0nOELu3yobY1KJ8fo7+2hgimDxP8xCEx7hwAC2716JwqfpGS4kANPd
	ODjGLrIPSs3ACNaN0XQyzhsHIH7nwZrAYg1SbQCT2e2PJVHPf0efZVW9HVdHBC9Jx5zCz9xPHQj
	IAqriJ1b+uqt6JSYR+qRcTvt6EqjfImRqY/2LsnmN84kXHYVZCdMF6QTmOPqZCYHJOD3WzyAeFv
	Qa3mQ1QhaaRPrMu+Ud72dDe2aPvsac7K+lE77sZ6M+YNX/cw9PLTa9hiN
X-Received: by 2002:a05:6000:1842:b0:43b:3f2d:7d43 with SMTP id ffacd0b85a97d-43b8898d4a9mr10906931f8f.8.1774522082044;
        Thu, 26 Mar 2026 03:48:02 -0700 (PDT)
X-Received: by 2002:a05:6000:1842:b0:43b:3f2d:7d43 with SMTP id ffacd0b85a97d-43b8898d4a9mr10906883f8f.8.1774522081511;
        Thu, 26 Mar 2026 03:48:01 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df85csm9896629f8f.28.2026.03.26.03.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 03:48:01 -0700 (PDT)
Message-ID: <3dd87db5-ec50-4019-b320-79319475e746@redhat.com>
Date: Thu, 26 Mar 2026 11:48:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFC: pn533: bound the UART receive buffer
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@kernel.org, mingo@kernel.org,
 kees@kernel.org
References: <20260323072409.60086-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260323072409.60086-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271981-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C34BA333EAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 8:24 AM, Pengpeng Hou wrote:
> pn532_receive_buf() appends every incoming byte to dev->recv_skb and
> only resets the buffer after pn532_uart_rx_is_frame() recognizes a
> complete frame. A continuous stream of bytes without a valid PN532 frame
> header therefore keeps growing the skb until skb_put_u8() hits the tail
> limit.
> 
> Drop the accumulated partial frame once the fixed receive buffer is full
> so malformed UART traffic cannot grow the skb past
> PN532_UART_SKB_BUFF_LEN.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

This looks line 'net' material. Could you please provide a suitable
Fixes tag?

Thanks,

Paolo


