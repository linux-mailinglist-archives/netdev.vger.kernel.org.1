Return-Path: <netdev+bounces-278772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMZ/L7KO32l5VAAAu9opvQ
	(envelope-from <netdev+bounces-278772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:12:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1EC404B3B
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01AF6300D621
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40AA39656E;
	Wed, 15 Apr 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC0cUE0G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ovYCe5Bx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A80330D50
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258686; cv=none; b=hjU+AuU5jufrT3qHc6d7KUWlOyZDIyxaux6WfFVVvZrqPA8IB8cjrSKxbjgNbZ3oAIkY38x5RHfQOBG2c64cLW7Eyqy6ZYGLoIMM8a6kJWUgt3b1amB+aS3kYUF/sjO0afmYOd+5cRQ08jLv3PGtP1T9nRoyKqcO9+tZAQcXyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258686; c=relaxed/simple;
	bh=HOy4QBTiHtu5pZJktO361ZlyF5xmQN/JVgQvXBzyBow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjwnqEyByvif0OF2bgbxPXvUpeyzN1BUUg+xgNxLpTJDgXWGbbjk6aXUD40L1cLpX7FyJCBNN9YC+ksnNY4SGnQ8UUjrQGgK55leYaBCsWy4XTFu9GRyVPRRZ1dmjG3w4U8gmweRi2HWZ7zo8g13d+kdwrEwbiQa9Kx7q+Ug96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OC0cUE0G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ovYCe5Bx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776258683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WL2SJseQynMpG1hsJR3ThfhQkhlDiJgfMk9Ad5tgV64=;
	b=OC0cUE0GibiyV5D9TNdQaTeYxHt2GmaRLg2/cO7SkptEPo8PIzK5+kagAUbGT7WeC7FLAp
	jzN+MuouDFqYXu84hsnhR9xM5Et8vjfiMcILOGKZ5BATwYy7bw6ZMTT0+u4ZUBe7N2fgZq
	tOUHM3wrmE3tQFWmAg0rQeNQT9hjiic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-N7Q4dLm5Oo2xYqFDt-q2oQ-1; Wed, 15 Apr 2026 09:11:21 -0400
X-MC-Unique: N7Q4dLm5Oo2xYqFDt-q2oQ-1
X-Mimecast-MFC-AGG-ID: N7Q4dLm5Oo2xYqFDt-q2oQ_1776258681
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so39322125e9.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776258681; x=1776863481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WL2SJseQynMpG1hsJR3ThfhQkhlDiJgfMk9Ad5tgV64=;
        b=ovYCe5BxCf4ZJOYJBPOnfp6HYj0TjwuWZTHIWjpRM4eLJECPj9h6VYTasfjTkQZJmK
         8mBh2d5DsSXXFv+5ae58Sg1lPj2GlGGQjAG5aP4A7X5k57+uYuRKI3qM5lU1pPFyJm8v
         0STeDlys1cucwN4FMwY75jW0P4epZWqjU4bQJJNFmO4WZ1cUIkLjxEnSeSpYnh4Rgf8H
         9WO+Qj7F3f/yWTB0eBSAX1E3fvF5ojL3X43tmnbC4Sj3jm7x4Qj6NtG39mDJ/7N9yQ/l
         wxbOSVvX2Wk0w7Vf70gcDOezX4/DqOyl7bXzC+FA5LzOi6CfI4saa/AmYY1QncMN+zoj
         pDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258681; x=1776863481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WL2SJseQynMpG1hsJR3ThfhQkhlDiJgfMk9Ad5tgV64=;
        b=JcqRrfsamD5yLrZFsn21NXpnre52FaZTgjOd16akGTBKyBd/PR5v165ecs8Kl5faMW
         qvXj5E5JTZE/rdU0u9LJhtqSbPe2twBsopNMErqIqWQ66KkF2iitul5Sp7WCLU4nczlu
         bc3necsnLtlUFzuvJYYQTt5HmLxswg9IOvpvXSNb8GxZ78/hvsPyUX0t44zVc7fU6jN/
         YC9GU4CC+VHU9gUTBfrbjSjg+mSnG3Ao15rqt/X2MOQCHdVoGvb9X+7DF0BLqqLJtplk
         amLOKxaMx2PKLnVNJ8A+3i3HV6v2WAFx7Eei3XBhJJkxTNMJhzvze3lA+1pRM+rcOvnm
         pG7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/sFVwPWEKe5cCHba5GMn6roLJHNEVAfHalVzAq+/DdWnyHXs+fGugtboyoT3DhZDGbsjwvVKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNLy5YseWN2//l6RN44wBOnXwjyv9xlQ+HVZEbV3iZXai85ui0
	hfa3NovFD+W0vjdQwD/eIoUGOn8kdDVxSyoHx5AheGqUuR1sdHO/UXaMbnM88ZsEaJslI30v6Pe
	s/+d+k1hf5dr2sEoH7ezKDWaJriJm29Z3ZuwvsQyVgKH3+iB60c2dis3i0Q==
X-Gm-Gg: AeBDies6yk0wGkV1/hp6U3DN+i4ejNzBjHejOU5bpd5TU3fas7soqk8IxrrCVImm0WU
	KcfslGHK7BcjtuUrXnotZZsJuejMCjR3e7dxMUTCGnAdtX5DnHEjFCwlj8KdkyHOhD3zOr0Euoz
	w8nzTumnvunqNwTAe2nuquzDMDwNVCFGNB98VB0xK63rbUVcbp2rU9WuBtjSBibAKU8S9Qlf1Tc
	l4ycI/p1c6u4sBUTLWOTgRQP5F4W8zkyN+0WC63Uf3gWni3/DJUvxhN2WO571epws0RkjjGmDi5
	8wLkkwoojWn8iE2Md3S+fXXTsX0yt35/j6ubDcr5uuIlSqjWUTD2YEPF6EJhLS5VvjwMZRbBZDr
	BCWUDSoZDzFL4iSq/AF/9yaHhR60=
X-Received: by 2002:a05:600c:6994:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-488d67bbcbamr306254075e9.3.1776258680470;
        Wed, 15 Apr 2026 06:11:20 -0700 (PDT)
X-Received: by 2002:a05:600c:6994:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-488d67bbcbamr306253665e9.3.1776258679964;
        Wed, 15 Apr 2026 06:11:19 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ebd0e1sm20362525e9.28.2026.04.15.06.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:11:19 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:11:16 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] vsock/test: fix MSG_PEEK handling in
 recv_buf()
Message-ID: <ad-OSiCXGAXKgxrx@leonardi-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
 <ad9uYrUjgCkW1D_k@sgarzare-redhat>
 <ad96TgXHW_jKitls@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad96TgXHW_jKitls@sgarzare-redhat>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278772-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E1EC404B3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 01:54:43PM +0200, Stefano Garzarella wrote:
>On Wed, Apr 15, 2026 at 01:31:11PM +0200, Stefano Garzarella wrote:
>>On Tue, Apr 14, 2026 at 06:10:22PM +0200, Luigi Leonardi wrote:
>>>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>>>`recv` until all requested bytes are available or an error occurs.
>>>
>>>The problem is how it calculates the amount of bytes read: MSG_PEEK
>>>doesn't consume any bytes, will re-read the same bytes from the buffer
>>>head, so, summing the return value every time is wrong.
>>>
>>>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
>>>requested amount is more than the bytes available, the loop will never
>>>terminate, because `recv` will never return EOF. For this reason we need
>>>to compare the amount of read bytes with the number of bytes expected.
>>>
>>>Add a check, and if the MSG_PEEK flag is present, update the counter of
>>>read bytes differently, and break if we read the expected amount.
>>
>>nit: "..., update the counter for bytes read only after all expected
>>bytes have been read and break out of the loop; otherwise, try again
>>after a short delay to avoid consuming too many CPU cycles."
>>
>>>
>>>This allows us to simplify the `test_stream_credit_update_test`, by
>>>reusing `recv_buf`, like some other tests already do.
>>>
>>>This also fixes callers that pass MSG_PEEK to recv_buf().
>>
>>nit: this is implicit from the first part of the description.
>>
>>>
>>>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>---
>>>tools/testing/vsock/util.c       | 15 +++++++++++++++
>>>tools/testing/vsock/vsock_test.c | 13 +------------
>>>2 files changed, 16 insertions(+), 12 deletions(-)
>>>
>>>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>>>index 1fe1338c79cd..2c9ee3210090 100644
>>>--- a/tools/testing/vsock/util.c
>>>+++ b/tools/testing/vsock/util.c
>>>@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
>>>	}
>>>}
>>>
>>>+#define RECV_PEEK_RETRY_USEC 10
>>
>>10 usec IMO are a bit low, it could be the same order of the 
>>syscalls involved in the loop, I'd go to some milliseconds like we 
>>do for SEND_SLEEP_USEC.
>>
>>>+
>>>/* Receive bytes in a buffer and check the return value.
>>>+ *
>>>+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
>>>+ * reads cannot be summed. Instead, the function retries until recv() returns
>>>+ * exactly expected_ret bytes in a single call.
>>
>>I'd replace with something like this:
>>
>>  * When MSG_PEEK is set, recv() is retried until it returns exactly
>>  * expected_ret bytes. The function returns on error, EOF, or timeout
>>  * as usual.
>>
>>Thanks,
>>Stefano
>>
>>>*
>>>* expected_ret:
>>>*  <0 Negative errno (for testing errors)
>>>@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
>>>		if (ret <= 0)
>>>			break;
>>>
>>>+		if (flags & MSG_PEEK) {
>>>+			if (ret == expected_ret) {
>
>On second thought, I think it would be more appropriate to check for
>`ret >= expected_ret` here, because all subsequent recv() will
>definitely return more bytes, so there’s no point in continuing the
>loop... and anyway, we’ll check the result later, so just that change
>should be fine.
>
>And of course I'd update the comment on top in this way:
>
>   * When MSG_PEEK is set, recv() is retried until it returns at least
>   * expected_ret bytes. The function returns on error, EOF, or timeout
>   * as usual.
>
>Thanks,
>Stefano
>

Good idea, will do.

Thanks!
Luigi


