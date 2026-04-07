Return-Path: <netdev+bounces-276127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMN7AMNI1Wk44AcAu9opvQ
	(envelope-from <netdev+bounces-276127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:11:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F03B2CD3
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 575E2300C90E
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4AA3C457A;
	Tue,  7 Apr 2026 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTiwzvFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B83BA258
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585255; cv=none; b=LRoxFWcjcTubAWVf3aqDIuVRmSEjibNh79myaobycY3DXNy5vtfQ7nG5PlYLZk4JsZ5JjkcSbLw0WY9QF//eBpsgoNJ40xToc/I9EaUVPLkYBCgJgWlyUk7Ze5As3manITy92bv27Fbe5X4MedA4mXFPdr9yfnZXDX6PGhAqtcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585255; c=relaxed/simple;
	bh=iJsd66IuspM0ge/71Gn8cxGwjgnkHiA8PQsSrD/F9dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siFnjNW5UrZU6qb3K5ijzx/C5vkMpJnCz+fKsRpzkF1wiArHS4wxDMMXok1TmzYqj7GF9jvAOJVCP9Sh1DDV2l5ZLRbF/pQ7/Mtd10KaK78bFtcMQ4Xkbii2w9KAKxpb2+wOKCG8qUDz2QMc/4kbS1BnUqKBey5f01uQXJgL3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTiwzvFX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d933da14f0so183884185a.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 11:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775585253; x=1776190053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7Fq6aH8WpJcy6AynIGinusO/d1EuraYRO46ccF/lW8=;
        b=PTiwzvFX25anMGD89FKLz4ZqOumxeFNpeSlGM5pOURloBJDxhFEgbwmmaUbCBYZ1s6
         Pw67jM3WZoA1Wo9SPnJqqUXuNJ+lHBEcTJKlqwE06ydxTeHIdg7R8DjQcSG1976IkTsC
         eg8nhXKSBRxjxc8Vgvys7d4QmYsns8svAmcEoXA8S23Kr8cRZslZLrS6WI7X5FsVWhY2
         5vskMMw979xnXy7XUuAAzXN3iq8I1gs5ddGdodcpLA59lAVfa1uguNDAFQXTjL7kvpqQ
         nvIaU1gzzGgxH0Ij5snQNsUSPpWdBVlX39/sNPmAGJsxUF20BzLzS12MHIVa2OBO81Ei
         NsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775585253; x=1776190053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7Fq6aH8WpJcy6AynIGinusO/d1EuraYRO46ccF/lW8=;
        b=YiRkgM0nDie7gDDstCX40OnSSXg61CdJXPXX+EhAiI8f9gBGlSmg0yIzgJx8+J8gLn
         XjnOKLxLwWCBb8oaxEApytXJInG/NXESYMw5WbuwNFXdXGg0auNuBsPVwjSTXoiFoMHa
         l5NsR8HnoZonRUIf4zoAMNQ1vKUgVeI4Y6a6Vyu37j0vmZPi/zHyW6t1NoQyFOeYLvQS
         jT/gWgihJqYV6ZVlImkvY8CNk8ush/FCl1Hgjxx38Vsf/ivaCl6agpmzMcu8sr+Es4q0
         YXmsgDva0/l6A5q1EJSvlZQi5rrEdIBBEHOAn9yuFqSKHhFh0CI0OcKYyYJ2puLnw7Gr
         +9NA==
X-Forwarded-Encrypted: i=1; AJvYcCWEy/KNlTaxaw2xbPXR/2/N6VCJekCoDLeqRGz7lNM9x8l7sxuYxtlSrbXUk0fu05WJMCNXJls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxsnMpk/04Vekx6Bb7lECPR2QdqrRtgH1g/mQZYTNiWeSTHsAq
	p2G7SRmgtwZOlQqEHjqujp52hEejlFpte4uBVvdwdzXg9ZW6yhO/FX1p
X-Gm-Gg: AeBDieu5zqoDrY7Wgc30Hbv8Zx1sZGkuD0ba6mdF/qJ3U7xxHSIwS/33M/UzdJQdSYH
	TWxU9Io77UHYqnNRNuR/ohZYyqOWBQoM+b5JEgmfzWYWunx/yX08mYTUxgoK6xnq8S3KASFUZ0z
	EUOX5ZnljoGxCzIgm9ewxVVBP1t6nzOfq0NhG8A7EKfZJxrjYKum2Ey7R5FpM0ECyU60zsOI1cz
	uM8BmUnAiBuV/GO/eeKPg9kMd+C0pV5IR1ckm6JZrGKMKt9c8LhpDiifUEQN2eVj6naXJ9hI4cg
	5fEp+2iJc+ItqzmdH0C+8hxXM6iR5mJiTIZQ/2Ip/rVii9Lboj8u2r0zRt6cOhbr6NMmgleO+/6
	9hOZO7wbSDa9qM7i0fFmOeoSEqHnHYrwpuq35QsAQXOv7g0nOPATFYKNz9zq9NOkaKU45MlFIcn
	rm8F96oJ7kkPPZfxUeWPo91eiCa98AQCiUupc9Qm7M0nYiwX+qfoEiogC+5lxWIoAAPm8PAOAeP
	0YWJyvEDjM=
X-Received: by 2002:a05:620a:29d4:b0:8cd:9bf2:60e8 with SMTP id af79cd13be357-8d41e81fbf7mr2479518585a.59.1775585253219;
        Tue, 07 Apr 2026 11:07:33 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:5ca:ff28:651b:13f5? ([2620:10d:c091:500::7feb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5393a07sm1371543485a.4.2026.04.07.11.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 11:07:32 -0700 (PDT)
Message-ID: <fdf2bda7-94da-4c4a-97fb-4e6810376370@gmail.com>
Date: Tue, 7 Apr 2026 14:07:31 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] psp: add crypt-offset and spi-threshold
 attributes
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 kiran.kella@broadcom.com, sachin.suman@broadcom.com
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406181445.1fb8308e@kernel.org>
 <CANQF7iAF6DAMQWv=VSu=nTmb1CyALvVtH8xT2k0CCY0rKk3ggQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <CANQF7iAF6DAMQWv=VSu=nTmb1CyALvVtH8xT2k0CCY0rKk3ggQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276127-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A1F03B2CD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/7/26 11:39 AM, Akhilesh Samineni wrote:
> On Tue, Apr 7, 2026 at 6:44 AM Jakub Kicinski <kuba@kernel.org> wrote:
>> On Mon,  6 Apr 2026 15:23:02 -0700 Akhilesh Samineni wrote:
>>> This series introduces two new configurable per-device attributes to
>>> the PSP (PSP Security Protocol) subsystem: crypt-offset and spi-threshold.
>> Please read this document:
>> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>> --
> Thank you for the link. I have reviewed the netdev process documentation.
> I’ve ensured my patches pass checkpatch and include the correct maintainers.


Hi Akhilesh. There's a sentence in the netdevsim section of that 
document that is problematic for the series as it is currently: 
"netdevsim in itself is not considered a use case/user. You must also 
implement the new APIs in a real driver."


