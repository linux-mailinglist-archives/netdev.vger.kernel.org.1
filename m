Return-Path: <netdev+bounces-258419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBoCIQKMjWnq3wAAu9opvQ
	(envelope-from <netdev+bounces-258419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 09:14:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E215712B25C
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 09:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 922BA307DD3E
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A42C234C;
	Thu, 12 Feb 2026 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akNf8w7E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqQmqKNS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F42C21C2
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884093; cv=pass; b=jYSvZHFwojC725IPf6jFSOC43Npk4LqHlBTGbDgfiAZ6FG8G2Nc/l3ni0ftadBGAzx3DRA5YCI7wv27NKvXBnoNMmLskFCUcyO8OAYBgObbLGHsVuriXjKClNVoCnvbuHNKHYtBTyWz8I8888Ho0Kk+mEuX/7rHpSN2Rtxnm3ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884093; c=relaxed/simple;
	bh=Zgq8DJoA6WUR5EsSG3FnMq7s1ufyN0BteUBIYmUKyrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6lzGT0js8n+67w5QsR9mEw2fbye09o9C/p2rjsSODuZ2EO1xxJibGS0iHtYdqg8GDBOlvD9dCWYVcg6X4beqTD2epEbMlZofEn+9KJyY6im6U3xAI5M+RG8hqgUhHhAzJUsHLlnflQqY5tYy2vrpfpNHtMcZ+HXFK5PoC33ym4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akNf8w7E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EqQmqKNS; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770884089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vX5ZAlzRNWVVhwKCkmdZDPCD+5WodZWF1hQ8qHCxsA=;
	b=akNf8w7ERa0yUCtXXEF4uOrY7CYDojf1P42GNxNKKhEtxxguYGcGND8tSsrSg0FqvHW8il
	K97W51lyqn5uXt5YH7qV3J7MHL3hEQAMSqP9Lk9l9V7vDIVZOM0slQvmEDjYugg+sYk2/J
	W/EVmjtvcLQMtyruzhj3saQeo4MXucg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-TiNinB-RMTqn5CzK9qk64w-1; Thu, 12 Feb 2026 03:14:48 -0500
X-MC-Unique: TiNinB-RMTqn5CzK9qk64w-1
X-Mimecast-MFC-AGG-ID: TiNinB-RMTqn5CzK9qk64w_1770884087
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a863be8508so79467265ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 00:14:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770884083; cv=none;
        d=google.com; s=arc-20240605;
        b=b9dsP4JqVrEdTtdUMYcIJulnymmixEYbyqBBrUyxedwy+xeGVgBsQVLjNlMIK3dBxM
         XeTiNYvXqAdszDNHMjkvHSPhJ84f4po/ExM6WkB4GyZTrif/TPgyJbDwYRSlRmeRQIru
         5k1b2J57+dc7ym1DXvFzeF/UlS4GjnH6fUz8bZqXsBtjx/A/0PdQ0XKtbw6ik4rKFMKs
         4o1VqXqLv6vqy4lYaH7QGvziucOVFwcizEt6nZfN8V9hA7UKSkSN9ZV7UP46qXE3yex5
         5QDa4AinLDN1j9H11YcB4NMthlDwYXcYi/TgxlsKGpZmm1q3NMIuBiBJtms4U1yEKEj3
         V4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3vX5ZAlzRNWVVhwKCkmdZDPCD+5WodZWF1hQ8qHCxsA=;
        fh=ave33h0OlLcWf5LDz8Kv4yzjvlO/lmUavk6Spvj080o=;
        b=MTwD+KOMdhaYxOa8SPhGptjRHcK5fNBuOzyjXCQuKCy3FYVWA/fqGQq8VEFqSjW/7y
         Fv7TPhGpKOEyFDXGmUiHM32cXBDiP2dRzIiPY+2c2Gy73tFdeQED7QQoepLUdTUZxS6D
         43dcEIM7X0ktRCo77/Jt+jmwc155Q/CkaLKNS5yLhTA00sBkVAjMuLGo0AkRkK8aaXqT
         uxEdM/EofTi4EhT6qtD6cGQrDuwzawLD1btQVKf9k2KNHF3XIuU9qXxZRhXDquuagm50
         2bUOQIqAKbLs/PIlf3GWvDEvv4UFxNYXY7G1+5Jr4qnuW8hdTCchmH4zjJUJjV3CxyBn
         WnPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770884083; x=1771488883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vX5ZAlzRNWVVhwKCkmdZDPCD+5WodZWF1hQ8qHCxsA=;
        b=EqQmqKNS6vZL4cFq+QLQu3nDRflbkRO89L1qAWbZiBE2XeVmwqfimKTUgLJmjO2Tl9
         mIQ6uHRbIHN7DbiIUdyg6pxkCZcCfghhAnIg7JK/10KYEF0mbyltv/8XfnUEbY9h0EEt
         4shWxKB+4DLkxbBtdW0/+i8bEXv2HmnaKTGHOEDvAQFyYnyPf92bJ7iaAeYtfaRjdf/z
         yhhGHKg3NqYeTZZ67G6Rr8QRwaW5pBvinjeRNzfM5c48keO6j5wsq2D+dNGIRnnsmhkP
         BdxbrxY9VewTak5xDiHtqSXA8hpWMJAHD2KzScOKVgNoId0J8xcZ9zc3bqL2LCEZOIU5
         lJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770884083; x=1771488883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vX5ZAlzRNWVVhwKCkmdZDPCD+5WodZWF1hQ8qHCxsA=;
        b=iP4gQW0duO7rFq2i0zhv2Pj1PUvk9Ak1RXqpxSm9ak22TcU8IN31UvG23yoqBKdKMo
         gn1pnyxPjxTeeBRJOq6CUQsPYOBAFaD6mwwvFOP8EBylHfCudX7q4WIWZvXZDaxUNikV
         f3Q9FabSNgs07RexWmU+y+PguAnnTzo9577ACuN5QiRhowU6QPAAUlNdji+FKnJ7uUIa
         rUaDxQtfF4muQg7IF7NpyDme0CzF1F6NYSMzA2wS08YVEr4GmJfPUe+kW1hO+CWxGEDT
         wO3/KSE7rly14PTgypaluyFSkoPffI3Xz1aMS1VicnVKx3boTCX95J7P7LgRp1fQsqXP
         Dkow==
X-Forwarded-Encrypted: i=1; AJvYcCXuSVgVGtAF2EtbZUCmDrWYHkkbnSEOBrNechYaU/gELP1tGQLQI6AUm5wcYFAlzl1eIji+qCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YydBwcoTSE6gFYvQPEjW3tO4HLb2pmuYTuPYXQQ444zPMOfTkwP
	E/3/oDoPlEoYbl1vuk6ErlmyEpX8djeghyhhViZeP+zB5605/MonrLOXOeZ4x5NttvctQrTucN0
	/rKOpEXkDVNmXLGIKJvSeL69mWM35JsYvNG4rOPGdipkQPj7Vst09Rz48M9vw1rf36ijwSp73q/
	53JbIDe8Yv53Cspoi8DyLLDYqteK5VLnjF
X-Gm-Gg: AZuq6aKZLZ3jxNBUXKswnbb98uHIwqMnzyIpmkktZLQleYCN5X1TFUKhMXqk8+FM5nL
	xkXUhgRuHuNuCkTEvzcfwdDVCqXT0zfpZc0LWa10mNXb3qnXujLr+1Sm3ribPNGWhWHViiJzx0Y
	nYgYMSk7RHOjx1S9awgtCH0f8EqqZdBEVmsZOpxUFIP++qy8ZzW7V1q+ru9WbC/J9caA7uvbK8m
	ENo/D0=
X-Received: by 2002:a17:903:32d1:b0:2a7:845a:7eb2 with SMTP id d9443c01a7336-2ab399c7c23mr17611185ad.14.1770884082729;
        Thu, 12 Feb 2026 00:14:42 -0800 (PST)
X-Received: by 2002:a17:903:32d1:b0:2a7:845a:7eb2 with SMTP id
 d9443c01a7336-2ab399c7c23mr17610825ad.14.1770884082164; Thu, 12 Feb 2026
 00:14:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
 <CACGkMEsJKeEsH=G8H5RzMNHY4g3HNdciMDMhciShawh-9Xb9hg@mail.gmail.com>
 <bc1078e5-65fc-4de6-8475-517f626d8d96@tu-dortmund.de> <3a1d6232-efe4-4e79-a196-44794fdc0f33@tu-dortmund.de>
 <CACGkMEv71kn91FPAUrxJg=YB3+B0MRTgOidMPHjK7Qq0WEhGtw@mail.gmail.com>
 <260f48cd-caa1-4684-a235-8e1192722b3a@tu-dortmund.de> <CACGkMEsVMz+vS3KxykYBGXvyt3MZcstnYWUiYJZhLSMoHC5Smw@mail.gmail.com>
 <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de> <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
 <0ebc00ba-35e7-4570-a44f-b0ae634f2316@tu-dortmund.de> <CACGkMEsJtE3RehWQ8BaDL2HdFPK=iW+ZaEAN1TekAMWwor5tjQ@mail.gmail.com>
 <197573a1-df52-4928-adb9-55a7a4f78839@tu-dortmund.de> <CACGkMEveEXky_rTrvRrfi7qix12GG91GfyqnwB6Tu-dnjqAm9A@mail.gmail.com>
 <0c776172-2f02-47fc-babf-2871adca42cb@tu-dortmund.de> <CACGkMEte=LwvkxPh-tesJHLVYQV1YZF4is1Yamokhkzaf5GOWw@mail.gmail.com>
 <205aa139-975d-4092-aa04-a2c570ae43a6@tu-dortmund.de>
In-Reply-To: <205aa139-975d-4092-aa04-a2c570ae43a6@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Feb 2026 16:14:30 +0800
X-Gm-Features: AZwV_QheTNfpCJUorx0nwhWmu6itSHiTF96ZgGvvyUat4vjMHutlZFA0jGbypSk
Message-ID: <CACGkMEtRikexX=cJz8zmuvW7mcO7uCFdG7AoHQLOezrsb5nbgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258419-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E215712B25C
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 2:18=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 2/6/26 04:21, Jason Wang wrote:
> > On Fri, Feb 6, 2026 at 6:28=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 2/5/26 04:59, Jason Wang wrote:
> >>> On Wed, Feb 4, 2026 at 11:44=E2=80=AFPM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 2/3/26 04:48, Jason Wang wrote:
> >>>>> On Mon, Feb 2, 2026 at 4:19=E2=80=AFAM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> On 1/30/26 02:51, Jason Wang wrote:
> >>>>>>> On Thu, Jan 29, 2026 at 5:25=E2=80=AFPM Simon Schippers
> >>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>
> >>>>>>>> On 1/29/26 02:14, Jason Wang wrote:
> >>>>>>>>> On Wed, Jan 28, 2026 at 3:54=E2=80=AFPM Simon Schippers
> >>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 1/28/26 08:03, Jason Wang wrote:
> >>>>>>>>>>> On Wed, Jan 28, 2026 at 12:48=E2=80=AFAM Simon Schippers
> >>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 1/23/26 10:54, Simon Schippers wrote:
> >>>>>>>>>>>>> On 1/23/26 04:05, Jason Wang wrote:
> >>>>>>>>>>>>>> On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowa=
ng@redhat.com> wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> >>>>>>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 1/9/26 07:02, Jason Wang wrote:
> >>>>>>>>>>>>>>>>> On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> >>>>>>>>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> On 1/8/26 04:38, Jason Wang wrote:
> >>>>>>>>>>>>>>>>>>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schipper=
s
> >>>>>>>>>>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Introduce {tun,tap}_ring_consume() helpers that wrap=
 __ptr_ring_consume()
> >>>>>>>>>>>>>>>>>>>> and wake the corresponding netdev subqueue when cons=
uming an entry frees
> >>>>>>>>>>>>>>>>>>>> space in the underlying ptr_ring.
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Stopping of the netdev queue when the ptr_ring is fu=
ll will be introduced
> >>>>>>>>>>>>>>>>>>>> in an upcoming commit.
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmun=
d.de>
> >>>>>>>>>>>>>>>>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.=
de>
> >>>>>>>>>>>>>>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-d=
ortmund.de>
> >>>>>>>>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>>>>>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>>>>>>>>>>>>>>>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>>>>>>>>>>>>>>>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>>>>>>>>>>>>>>>> index 1197f245e873..2442cf7ac385 100644
> >>>>>>>>>>>>>>>>>>>> --- a/drivers/net/tap.c
> >>>>>>>>>>>>>>>>>>>> +++ b/drivers/net/tap.c
> >>>>>>>>>>>>>>>>>>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(str=
uct tap_queue *q,
> >>>>>>>>>>>>>>>>>>>>         return ret ? ret : total;
> >>>>>>>>>>>>>>>>>>>>  }
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>>>>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>>>>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>>>>>>>>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_creat=
ed_space(ring, 1))) {
> >>>>>>>>>>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>>>>>>>>>> +               dev =3D rcu_dereference(q->tap)->dev=
;
> >>>>>>>>>>>>>>>>>>>> +               netif_wake_subqueue(dev, q->queue_in=
dex);
> >>>>>>>>>>>>>>>>>>>> +               rcu_read_unlock();
> >>>>>>>>>>>>>>>>>>>> +       }
> >>>>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>>>> +       spin_unlock(&ring->consumer_lock);
> >>>>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>>>> +       return ptr;
> >>>>>>>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>>>>>>>>>>>>>>>                            struct iov_iter *to,
> >>>>>>>>>>>>>>>>>>>>                            int noblock, struct sk_bu=
ff *skb)
> >>>>>>>>>>>>>>>>>>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struc=
t tap_queue *q,
> >>>>>>>>>>>>>>>>>>>>                                         TASK_INTERRU=
PTIBLE);
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>>                 /* Read frames from the queue */
> >>>>>>>>>>>>>>>>>>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>>>>>>>>>>>>>>>>>> +               skb =3D tap_ring_consume(q);
> >>>>>>>>>>>>>>>>>>>>                 if (skb)
> >>>>>>>>>>>>>>>>>>>>                         break;
> >>>>>>>>>>>>>>>>>>>>                 if (noblock) {
> >>>>>>>>>>>>>>>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>>>>>>>>>>>>>>>> index 8192740357a0..7148f9a844a4 100644
> >>>>>>>>>>>>>>>>>>>> --- a/drivers/net/tun.c
> >>>>>>>>>>>>>>>>>>>> +++ b/drivers/net/tun.c
> >>>>>>>>>>>>>>>>>>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(=
struct tun_struct *tun,
> >>>>>>>>>>>>>>>>>>>>         return total;
> >>>>>>>>>>>>>>>>>>>>  }
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> +static void *tun_ring_consume(struct tun_file *tfil=
e)
> >>>>>>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>>>>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>>>>>>>>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_creat=
ed_space(ring, 1))) {
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> I guess it's the "bug" I mentioned in the previous pa=
tch that leads to
> >>>>>>>>>>>>>>>>>>> the check of __ptr_ring_consume_created_space() here.=
 If it's true,
> >>>>>>>>>>>>>>>>>>> another call to tweak the current API.
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>>>>>>>>>> +               dev =3D rcu_dereference(tfile->tun)-=
>dev;
> >>>>>>>>>>>>>>>>>>>> +               netif_wake_subqueue(dev, tfile->queu=
e_index);
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>> This would cause the producer TX_SOFTIRQ to run on th=
e same cpu which
> >>>>>>>>>>>>>>>>>>> I'm not sure is what we want.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> What else would you suggest calling to wake the queue?
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> I don't have a good method in my mind, just want to poi=
nt out its implications.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I have to admit I'm a bit stuck at this point, particula=
rly with this
> >>>>>>>>>>>>>>>> aspect.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> What is the correct way to pass the producer CPU ID to t=
he consumer?
> >>>>>>>>>>>>>>>> Would it make sense to store smp_processor_id() in the t=
file inside
> >>>>>>>>>>>>>>>> tun_net_xmit(), or should it instead be stored in the sk=
b (similar to the
> >>>>>>>>>>>>>>>> XDP bit)? In the latter case, my concern is that this in=
formation may
> >>>>>>>>>>>>>>>> already be significantly outdated by the time it is used=
.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Based on that, my idea would be for the consumer to wake=
 the producer by
> >>>>>>>>>>>>>>>> invoking a new function (e.g., tun_wake_queue()) on the =
producer CPU via
> >>>>>>>>>>>>>>>> smp_call_function_single().
> >>>>>>>>>>>>>>>> Is this a reasonable approach?
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I'm not sure but it would introduce costs like IPI.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> More generally, would triggering TX_SOFTIRQ on the consu=
mer CPU be
> >>>>>>>>>>>>>>>> considered a deal-breaker for the patch set?
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> It depends on whether or not it has effects on the perfor=
mance.
> >>>>>>>>>>>>>>> Especially when vhost is pinned.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I meant we can benchmark to see the impact. For example, p=
in vhost to
> >>>>>>>>>>>>>> a specific CPU and the try to see the impact of the TX_SOF=
TIRQ.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Thanks
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I ran benchmarks with vhost pinned to CPU 0 using taskset -=
p -c 0 ...
> >>>>>>>>>>>>> for both the stock and patched versions. The benchmarks wer=
e run with
> >>>>>>>>>>>>> the full patch series applied, since testing only patches 1=
-3 would not
> >>>>>>>>>>>>> be meaningful - the queue is never stopped in that case, so=
 no
> >>>>>>>>>>>>> TX_SOFTIRQ is triggered.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Compared to the non-pinned CPU benchmarks in the cover lett=
er,
> >>>>>>>>>>>>> performance is lower for pktgen with a single thread but hi=
gher with
> >>>>>>>>>>>>> four threads. The results show no regression for the patche=
d version,
> >>>>>>>>>>>>> with even slight performance improvements observed:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> +-------------------------+-----------+----------------+
> >>>>>>>>>>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>>>>>>>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>>>>>>>>>> | 100M packets            |           |                |
> >>>>>>>>>>>>> | vhost pinned to core 0  |           |                |
> >>>>>>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>>>>>> | TAP       | Transmitted | 452 Kpps  | 454 Kpps       |
> >>>>>>>>>>>>> |  +        +-------------+-----------+----------------+
> >>>>>>>>>>>>> | vhost-net | Lost        | 1154 Kpps | 0              |
> >>>>>>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> +-------------------------+-----------+----------------+
> >>>>>>>>>>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>>>>>>>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>>>>>>>>>> | 100M packets            |           |                |
> >>>>>>>>>>>>> | vhost pinned to core 0  |           |                |
> >>>>>>>>>>>>> | *4 threads*             |           |                |
> >>>>>>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>>>>>> | TAP       | Transmitted | 71 Kpps   | 79 Kpps        |
> >>>>>>>>>>>>> |  +        +-------------+-----------+----------------+
> >>>>>>>>>>>>> | vhost-net | Lost        | 1527 Kpps | 0              |
> >>>>>>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>>>>
> >>>>>>>>>>> The PPS seems to be low. I'd suggest using testpmd (rxonly) m=
ode in
> >>>>>>>>>>> the guest or an xdp program that did XDP_DROP in the guest.
> >>>>>>>>>>
> >>>>>>>>>> I forgot to mention that these PPS values are per thread.
> >>>>>>>>>> So overall we have 71 Kpps * 4 =3D 284 Kpps and 79 Kpps * 4 =
=3D 326 Kpps,
> >>>>>>>>>> respectively. For packet loss, that comes out to 1154 Kpps * 4=
 =3D
> >>>>>>>>>> 4616 Kpps and 0, respectively.
> >>>>>>>>>>
> >>>>>>>>>> Sorry about that!
> >>>>>>>>>>
> >>>>>>>>>> The pktgen benchmarks with a single thread look fine, right?
> >>>>>>>>>
> >>>>>>>>> Still looks very low. E.g I just have a run of pktgen (using
> >>>>>>>>> pktgen_sample03_burst_single_flow.sh) without a XDP_DROP in the=
 guest,
> >>>>>>>>> I can get 1Mpps.
> >>>>>>>>
> >>>>>>>> Keep in mind that I am using an older CPU (i5-6300HQ). For the
> >>>>>>>> single-threaded tests I always used pktgen_sample01_simple.sh, a=
nd for
> >>>>>>>> the multi-threaded tests I always used pktgen_sample02_multiqueu=
e.sh.
> >>>>>>>>
> >>>>>>>> Using pktgen_sample03_burst_single_flow.sh as you did fails for =
me (even
> >>>>>>>> though the same parameters work fine for sample01 and sample02):
> >>>>>>>>
> >>>>>>>> samples/pktgen/pktgen_sample03_burst_single_flow.sh -i tap0 -m
> >>>>>>>> 52:54:00:12:34:56 -d 10.0.0.2 -n 100000000
> >>>>>>>> /samples/pktgen/functions.sh: line 79: echo: write error: Operat=
ion not
> >>>>>>>> supported
> >>>>>>>> ERROR: Write error(1) occurred
> >>>>>>>> cmd: "burst 32 > /proc/net/pktgen/tap0@0"
> >>>>>>>>
> >>>>>>>> ...and I do not know what I am doing wrong, even after looking a=
t
> >>>>>>>> Documentation/networking/pktgen.rst. Every burst size except 1 f=
ails.
> >>>>>>>> Any clues?
> >>>>>>>
> >>>>>>> Please use -b 0, and I'm Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz=
.
> >>>>>>
> >>>>>> I tried using "-b 0", and while it worked, there was no noticeable
> >>>>>> performance improvement.
> >>>>>>
> >>>>>>>
> >>>>>>> Another thing I can think of is to disable
> >>>>>>>
> >>>>>>> 1) mitigations in both guest and host
> >>>>>>> 2) any kernel debug features in both host and guest
> >>>>>>
> >>>>>> I also rebuilt the kernel with everything disabled under
> >>>>>> "Kernel hacking", but that didn=E2=80=99t make any difference eith=
er.
> >>>>>>
> >>>>>> Because of this, I ran "pktgen_sample01_simple.sh" and
> >>>>>> "pktgen_sample02_multiqueue.sh" on my AMD Ryzen 5 5600X system. Th=
e
> >>>>>> results were about 374 Kpps with TAP and 1192 Kpps with TAP+vhost_=
net,
> >>>>>> with very similar performance between the stock and patched kernel=
s.
> >>>>>>
> >>>>>> Personally, I think the low performance is to blame on the hardwar=
e.
> >>>>>
> >>>>> Let's double confirm this by:
> >>>>>
> >>>>> 1) make sure pktgen is using 100% CPU
> >>>>> 2) Perf doesn't show anything strange for pktgen thread
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>
> >>>> I ran pktgen using pktgen_sample01_simple.sh and, in parallel, start=
ed a
> >>>> 100 second perf stat measurement covering all kpktgend threads.
> >>>>
> >>>> Across all configurations, a single CPU was fully utilized.
> >>>>
> >>>> Apart from that, the patched variants show a higher branch frequency=
 and
> >>>> a slightly increased number of context switches.
> >>>>
> >>>>
> >>>> The detailed results are provided below:
> >>>>
> >>>> Processor: Ryzen 5 5600X
> >>>>
> >>>> pktgen command:
> >>>> sudo perf stat samples/pktgen/pktgen_sample01_simple.sh -i tap0 -m
> >>>> 52:54:00:12:34:56 -d 10.0.0.2 -n 10000000000
> >>>>
> >>>> perf stat command:
> >>>> sudo perf stat --timeout 100000 -p $(pgrep kpktgend | tr '\n' ,) -o =
X.txt
> >>>>
> >>>>
> >>>> Results:
> >>>> Stock TAP:
> >>>>             46.997      context-switches                 #    467,2 =
cs/sec  cs_per_second
> >>>>                  0      cpu-migrations                   #      0,0 =
migrations/sec  migrations_per_second
> >>>>                  0      page-faults                      #      0,0 =
faults/sec  page_faults_per_second
> >>>>         100.587,69 msec task-clock                       #      1,0 =
CPUs  CPUs_utilized
> >>>>      8.491.586.483      branch-misses                    #     10,9 =
%  branch_miss_rate         (50,24%)
> >>>>     77.734.761.406      branches                         #    772,8 =
M/sec  branch_frequency     (66,85%)
> >>>>    382.420.291.585      cpu-cycles                       #      3,8 =
GHz  cycles_frequency       (66,85%)
> >>>>    377.612.185.141      instructions                     #      1,0 =
instructions  insn_per_cycle  (66,85%)
> >>>>     84.012.185.936      stalled-cycles-frontend          #     0,22 =
frontend_cycles_idle        (66,35%)
> >>>>
> >>>>      100,100414494 seconds time elapsed
> >>>>
> >>>>
> >>>> Stock TAP+vhost-net:
> >>>>             47.087      context-switches                 #    468,1 =
cs/sec  cs_per_second
> >>>>                  0      cpu-migrations                   #      0,0 =
migrations/sec  migrations_per_second
> >>>>                  0      page-faults                      #      0,0 =
faults/sec  page_faults_per_second
> >>>>         100.594,09 msec task-clock                       #      1,0 =
CPUs  CPUs_utilized
> >>>>      8.034.703.613      branch-misses                    #     11,1 =
%  branch_miss_rate         (50,24%)
> >>>>     72.477.989.922      branches                         #    720,5 =
M/sec  branch_frequency     (66,86%)
> >>>>    382.218.276.832      cpu-cycles                       #      3,8 =
GHz  cycles_frequency       (66,85%)
> >>>>    349.555.577.281      instructions                     #      0,9 =
instructions  insn_per_cycle  (66,85%)
> >>>>     83.917.644.262      stalled-cycles-frontend          #     0,22 =
frontend_cycles_idle        (66,35%)
> >>>>
> >>>>      100,100520402 seconds time elapsed
> >>>>
> >>>>
> >>>> Patched TAP:
> >>>>             47.862      context-switches                 #    475,8 =
cs/sec  cs_per_second
> >>>>                  0      cpu-migrations                   #      0,0 =
migrations/sec  migrations_per_second
> >>>>                  0      page-faults                      #      0,0 =
faults/sec  page_faults_per_second
> >>>>         100.589,30 msec task-clock                       #      1,0 =
CPUs  CPUs_utilized
> >>>>      9.337.258.794      branch-misses                    #      9,4 =
%  branch_miss_rate         (50,19%)
> >>>>     99.518.421.676      branches                         #    989,4 =
M/sec  branch_frequency     (66,85%)
> >>>>    382.508.244.894      cpu-cycles                       #      3,8 =
GHz  cycles_frequency       (66,85%)
> >>>>    312.582.270.975      instructions                     #      0,8 =
instructions  insn_per_cycle  (66,85%)
> >>>>     76.338.503.984      stalled-cycles-frontend          #     0,20 =
frontend_cycles_idle        (66,39%)
> >>>>
> >>>>      100,101262454 seconds time elapsed
> >>>>
> >>>>
> >>>> Patched TAP+vhost-net:
> >>>>             47.892      context-switches                 #    476,1 =
cs/sec  cs_per_second
> >>>>                  0      cpu-migrations                   #      0,0 =
migrations/sec  migrations_per_second
> >>>>                  0      page-faults                      #      0,0 =
faults/sec  page_faults_per_second
> >>>>         100.581,95 msec task-clock                       #      1,0 =
CPUs  CPUs_utilized
> >>>>      9.083.588.313      branch-misses                    #     10,1 =
%  branch_miss_rate         (50,28%)
> >>>>     90.300.124.712      branches                         #    897,8 =
M/sec  branch_frequency     (66,85%)
> >>>>    382.374.510.376      cpu-cycles                       #      3,8 =
GHz  cycles_frequency       (66,85%)
> >>>>    340.089.181.199      instructions                     #      0,9 =
instructions  insn_per_cycle  (66,85%)
> >>>>     78.151.408.955      stalled-cycles-frontend          #     0,20 =
frontend_cycles_idle        (66,31%)
> >>>>
> >>>>      100,101212911 seconds time elapsed
> >>>
> >>> Thanks for sharing. I have more questions:
> >>>
> >>> 1) The number of CPU and vCPUs
> >>
> >> qemu runs with a single core. And my host system is now a Ryzen 5 5600=
x
> >> with 6 cores, 12 threads.
> >> This is my command for TAP+vhost-net:
> >>
> >> sudo qemu-system-x86_64 -hda debian.qcow2
> >> -netdev tap,id=3Dmynet0,ifname=3Dtap0,script=3Dno,downscript=3Dno,vhos=
t=3Don
> >> -device virtio-net-pci,netdev=3Dmynet0 -m 1024 -enable-kvm
> >>
> >> For TAP only it is the same but without vhost=3Don.
> >>
> >>> 2) If you pin vhost or vCPU threads
> >>
> >> Not in the previous shown benchmark. I pinned vhost in other benchmark=
s
> >> but since there is only minor PPS difference I omitted for the sake of
> >> simplicity.
> >>
> >>> 3) what does perf top looks like or perf top -p $pid_of_vhost
> >>
> >> The perf reports for the pid_of_vhost from pktgen_sample01_simple.sh
> >> with TAP+vhost-net (not pinned, pktgen single queue, fq_codel) are sho=
wn
> >> below. I can not see a huge difference between stock and patched.
> >>
> >> Also I included perf reports from the pktgen_pids. I find them more
> >> intersting because tun_net_xmit shows less overhead for the patched.
> >> I assume that is due to the stopped netdev queue.
> >>
> >> I have now benchmarked pretty much all possible combinations (with a
> >> script) of TAP/TAP+vhost-net, single/multi-queue pktgen, vhost
> >> pinned/not pinned, with/without -b 0, fq_codel/noqueue... All of that
> >> with perf records..
> >> I could share them if you want but I feel this is getting out of hand.
> >>
> >>
> >> Stock:
> >> sudo perf record -p "$vhost_pid"
> >> ...
> >> # Overhead  Command          Shared Object               Symbol
> >> # ........  ...............  ..........................  .............=
.............................
> >> #
> >>      5.97%  vhost-4874       [kernel.kallsyms]           [k] _copy_to_=
iter
> >>      2.68%  vhost-4874       [kernel.kallsyms]           [k] tun_do_re=
ad
> >>      2.23%  vhost-4874       [kernel.kallsyms]           [k] native_wr=
ite_msr
> >>      1.93%  vhost-4874       [kernel.kallsyms]           [k] __check_o=
bject_size
> >
> > Let's disable CONFIG_HARDENED_USERCOPY and retry.
> >
> >>      1.61%  vhost-4874       [kernel.kallsyms]           [k] __slab_fr=
ee.isra.0
> >>      1.56%  vhost-4874       [kernel.kallsyms]           [k] __get_use=
r_nocheck_2
> >>      1.54%  vhost-4874       [kernel.kallsyms]           [k] iov_iter_=
zero
> >>      1.45%  vhost-4874       [kernel.kallsyms]           [k] kmem_cach=
e_free
> >>      1.43%  vhost-4874       [kernel.kallsyms]           [k] tun_recvm=
sg
> >>      1.24%  vhost-4874       [kernel.kallsyms]           [k] sk_skb_re=
ason_drop
> >>      1.12%  vhost-4874       [kernel.kallsyms]           [k] srso_alia=
s_safe_ret
> >>      1.07%  vhost-4874       [kernel.kallsyms]           [k] native_re=
ad_msr
> >>      0.76%  vhost-4874       [kernel.kallsyms]           [k] simple_co=
py_to_iter
> >>      0.75%  vhost-4874       [kernel.kallsyms]           [k] srso_alia=
s_return_thunk
> >>      0.69%  vhost-4874       [vhost]                     [k] 0x0000000=
000002e70
> >>      0.59%  vhost-4874       [kernel.kallsyms]           [k] skb_relea=
se_data
> >>      0.59%  vhost-4874       [kernel.kallsyms]           [k] __skb_dat=
agram_iter
> >>      0.53%  vhost-4874       [vhost]                     [k] 0x0000000=
000002e5f
> >>      0.51%  vhost-4874       [kernel.kallsyms]           [k] slab_upda=
te_freelist.isra.0
> >>      0.46%  vhost-4874       [kernel.kallsyms]           [k] kfree_skb=
mem
> >>      0.44%  vhost-4874       [kernel.kallsyms]           [k] skb_copy_=
datagram_iter
> >>      0.43%  vhost-4874       [kernel.kallsyms]           [k] skb_free_=
head
> >>      0.37%  qemu-system-x86  [unknown]                   [k] 0xfffffff=
fba898b1b
> >>      0.35%  vhost-4874       [vhost]                     [k] 0x0000000=
000002e6b
> >>      0.33%  vhost-4874       [vhost_net]                 [k] 0x0000000=
00000357d
> >>      0.28%  vhost-4874       [kernel.kallsyms]           [k] __check_h=
eap_object
> >>      0.27%  vhost-4874       [vhost_net]                 [k] 0x0000000=
0000035f3
> >>      0.26%  vhost-4874       [vhost_net]                 [k] 0x0000000=
0000030f6
> >>      0.26%  vhost-4874       [kernel.kallsyms]           [k] __virt_ad=
dr_valid
> >>      0.24%  vhost-4874       [kernel.kallsyms]           [k] iov_iter_=
advance
> >>      0.22%  vhost-4874       [kernel.kallsyms]           [k] perf_even=
t_update_userpage
> >>      0.22%  vhost-4874       [kernel.kallsyms]           [k] check_sta=
ck_object
> >>      0.19%  qemu-system-x86  [unknown]                   [k] 0xfffffff=
fba2a68cd
> >>      0.19%  vhost-4874       [kernel.kallsyms]           [k] dequeue_e=
ntities
> >>      0.19%  vhost-4874       [vhost_net]                 [k] 0x0000000=
000003237
> >>      0.18%  vhost-4874       [vhost_net]                 [k] 0x0000000=
000003550
> >>      0.18%  vhost-4874       [kernel.kallsyms]           [k] x86_pmu_d=
el
> >>      0.18%  vhost-4874       [vhost_net]                 [k] 0x0000000=
0000034a0
> >>      0.17%  vhost-4874       [kernel.kallsyms]           [k] x86_pmu_d=
isable_all
> >>      0.16%  vhost-4874       [vhost_net]                 [k] 0x0000000=
000003523
> >>      0.16%  vhost-4874       [kernel.kallsyms]           [k] amd_pmu_a=
ddr_offset
> >> ...
> >>
> >>
> >> sudo perf record -p "$kpktgend_pids":
> >> ...
> >> # Overhead  Command      Shared Object      Symbol
> >> # ........  ...........  .................  ..........................=
.....................
> >> #
> >>     10.98%  kpktgend_0   [kernel.kallsyms]  [k] tun_net_xmit
> >>     10.45%  kpktgend_0   [kernel.kallsyms]  [k] memset
> >>      8.40%  kpktgend_0   [kernel.kallsyms]  [k] __alloc_skb
> >>      6.31%  kpktgend_0   [kernel.kallsyms]  [k] kmem_cache_alloc_node_=
noprof
> >>      3.13%  kpktgend_0   [kernel.kallsyms]  [k] srso_alias_safe_ret
> >>      2.40%  kpktgend_0   [kernel.kallsyms]  [k] sk_skb_reason_drop
> >>      2.11%  kpktgend_0   [kernel.kallsyms]  [k] srso_alias_return_thun=
k
> >
> > This is a hint that SRSO migitaion is enabled.
> >
> > Have you disabled CPU_MITIGATIONS via either Kconfig or kernel command
> > line (mitigations =3D off) for both host and guest?
> >
> > Thanks
> >
>
> Your both suggested changes really boosted the performance, especially
> for TAP.

Good to know that.

>
> I disabled SRSO mitigation with spec_rstack_overflow=3Doff and went from
> "Mitigation: Safe RET" to "Vulnerable" on the host. The VM showed "Not
> affected" but I applied spec_rstack_overflow=3Doff anyway.

I think we need to find the root cause of the regression.

>
> Here are some new benchmarks for pktgen_sample01_simple.sh:
> (I also have other available and I can share them if you want.)
>

It's a little hard to compare the diff, maybe you can do perf diff.

(Btw, it's near to the public holiday of spring festival in China, so
the reply might a slow).

Thanks


