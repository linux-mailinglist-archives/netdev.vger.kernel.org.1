Return-Path: <netdev+bounces-289967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOqkCqTGDWrg3AUAu9opvQ
	(envelope-from <netdev+bounces-289967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:35:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFCF58FB41
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41FFE320BF3E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB63EE1EC;
	Wed, 20 May 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF51/FNy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D433EDAD1
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286387; cv=pass; b=ml2Jq5MDcX8VC7PHVkFmblYlZx+xOZsKHCRfTEsfWWZUI+JznlKQXkYAds0Lzox27puzh4GJEGX8eEThSM6yK10LsnysQptyAnb3SkklIXpIdunr9ln/2+DCTSyi/sYAY2+qgvPL4X4O2ACpP0FbJnkO2gmHGjbWVZ3LDWWiRyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286387; c=relaxed/simple;
	bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZai+jATkyCjpNS/7iE85K+vVG2O6UWae8nJ0LQR9wm9GOFSG+8IcT4caIf+usWvOujrSN/+iJdBsqD4C0zpbJ5lZWvoPXfPz4e4n2b2YG0rzLjYPssO7kufXfhLwgU7q9Pf8vNhTX1VyaJwJA24rdFOKmRJInwrshVsrg4aJLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pF51/FNy; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd4c61765dso45853217b3.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779286385; cv=none;
        d=google.com; s=arc-20240605;
        b=GPmoW0tbBzDhZekjNZUY0c4xzbkL1ATS/X+SdfBy6NM7cRW5/I//Wck3l8S33NBj4r
         soHBKuazGQ7kDT3VT0sC5tlP1VP1CEcXoS8Zvr2nIrlAnf1CtOjV8vLBQM7RD1opupkL
         45MShqF9HrZAvERPo/itDTlsMHNuyRGoBe3Pt4u2o48wCPwnmrlWnYMnzGDkbOG6Uzln
         9VcXVBRAyVg++PwMfXF+u2PE2rXHz3JsPxsoNxYPdqBcSY8GQI6XdiMg++JxU/cmovj1
         5AMTmAF/Q4A8OAre+KPZZK1OfxzJTFSLok0EwtuH3CNjz+vpWXHNjysdqbLnGfWS5zXX
         imAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
        fh=0iCbp7Iyz5qgfnGV4vkj0fwyjVTBK/s4ncc6FfTN9nY=;
        b=b8ALFaQfv6mcT62VqAkxzG2nGErCUPGQ4xILadvdKZV3C4eaRb+IU3sLqPGFT0PJal
         zcUMFnVt7WYVAzKZurQ7k6hjeT05MXJOSgLnwknAmGB/TJaqhuK8zotnrSoL3m7SwRdk
         zfZlWRUzQnTdCoR/TCYp3YeXBrUsX1hPmb4T+QyYJJk41323e2EmNzU8Mk2RucKplb5X
         yI29IyIsqygR/l9BuCrzaUoKC28FQrouOd3svDoRkHJ47C6+T7MHQnbQRWVZZf+rQ9lP
         2b+UciDQXn9gqoBsJzN9JXy0DP6Cn7qQs7NUljO4FOBhr+VaqdWcLAPIlNtfZbuvpe1Q
         ARAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286385; x=1779891185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
        b=pF51/FNy/aGNyuPKZxf2LLRRzc6339p9TzxGRpp1NpOCaAChzTbDKcIKKxFiyYdz94
         8ZPl1zLMbIwxQCar7nY4utT+/6g7rD8r6Oqa4I+P/XabwlnZYlOzI04Jta6EfEppmrx1
         9O+zQiXRhl517v/nhZwM+6R5r6oThGd4ctK58L8/pKEiLUfDYBx6ps0nqUgmlHF2/mFq
         qZgIxRtuuAQWHZeoIiGmpNWClsE8HHCSXq1X5/d8Jk4YkcMW7Evoq/7HqsUFtjELulXx
         8DBW0htzglbzB6uDdDpCkOW+vdMcu59tcTYjohodZQCxX9e6YcrAQ4G0/2N/YDUtkdqX
         oKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286385; x=1779891185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sde/gBT/xp0UIfybWtie6NS5tW5ikwXgAQMSfd/pE0k=;
        b=FPuZrm8I+BQlm2aM8BMvf7RkwrZmNIiNP45LBHq+wkWDgfUsfagVqA3TzmCddLfbU0
         1MRCHzYpGN0YXVdoOWtCsaIO0E5CJLkfm0NjenbCECkKlw6iQH2Sx2Xr9iHoHJktVdA9
         BftPvnS8qzOBsjI+voDCMDwVC1tqbDWgUHHMTC3AFa3KXG5qzod1tyxgY6634twq6yLR
         6kHoYhHXuKXPN0UtjyMMffU0SAH82+xwFQGXSR/Kmlpgqm5tj1E/+95nlUJ13h6mvKne
         pukGh5mQz5zzw/2pqd4IE6A7/em78EFCV1fcfQxDAXN721iwdwtbsCiRtQc+pKOxCx/3
         d0xw==
X-Forwarded-Encrypted: i=1; AFNElJ9WYyPdqqyHN+s4FzuJK3i+gX/deSlZR54+s+eWfRx/g9SKvs95G53lRKVpSnl+4HdJQ7KPpF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0T5CTyYMr0q184dY8HAWQ8SorTbInD/UkxDnIVIxxuLlfFdeq
	/EUR82gZc71h+zaX442UciL5CgXgHKHmnTtzWX1gI57zbNVHAaAw9a20fCNv/NgRC6OvKnZcbii
	bI9qQetg+kDxU3mmU29YDVdI1Nnl2AyE=
X-Gm-Gg: Acq92OF6PnO5CC+hw9uF0JKnGlFFx3H8kLXwXoVAfH6X+LXx6Cfib5z6OYLhrZekFsR
	E2UgZ+Odi/ib6N1rcFjEHHi2kj/oQ7jagpRLV9Wy7qA6K+8ECto8SJTODsD9CK2GiL6T+J6iCm8
	gEf66HdVP8Q7uB3dykC6XDPQ6r/Vlm4tMLbipodzB6TYhP8/h4KbwjNXfhj9Q0dLeS9rYM/eGC3
	H4r0tc92M93mWXybZXVIpa+P2oOP3aSIMzYgFlmeQuA0Vh0jTMBfb1jFO24/YdXYBMMqg9RH6jf
	yw18OooHQp+kRrDqFyFZmADd+HbcptPIG6Ha0gjLyw26EVYiRehEt9lNAQ==
X-Received: by 2002:a05:690c:f09:b0:7bb:712:a768 with SMTP id
 00721157ae682-7c959b92a05mr260964467b3.7.1779286385081; Wed, 20 May 2026
 07:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com> <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
In-Reply-To: <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 10:12:53 -0400
X-Gm-Features: AVHnY4Jw2SUIqejxTca-2HXdzAfWn9R-0elBcKvZqiV0qBvm6QtxRM6lQabcQeY
Message-ID: <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289967-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9CFCF58FB41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 10:00=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Weird, does the AI come up with this? The id is actually _not_
> important because the error code will essentially indicate that the
> entire packet was rejected. Therefore, it doesn't matter if the id is
> for a request or a response, it still needs rejection if it exceeds
> the MTU, so this seems overengineered.

Yes, and I debated this with Claude, but it convinced me that the
lifted helpers were more idiomatic for the actual spec and bt system:
"The identifier shall match the first request command in the L2CAP
packet. If only responses are recognized, the packet shall be silently
discarded."

So if we ever lifted or refactored the code, it would be abundantly
clear/safe to reuse elsewhere.

There is also much shorter version that just peeks skb->data[1] and
exits early if not ident=3D0 if that's what you're going for.

Just let me know what version you prefer.

Thanks,
Mike

