Return-Path: <netdev+bounces-53252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5152801D0B
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 14:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4AC2819AB
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5BD18047;
	Sat,  2 Dec 2023 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="Pd5l3ydJ"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55A8B0;
	Sat,  2 Dec 2023 05:31:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701523868; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=XiyEKDyqz/dQz3e+JZ0Fmsf3c/NczdsDanVEOa1/C8oKJr7z8TJmzvgsmGEhFP6xkPomu6WkfdZYnj0x5O/blnz0l/NgOvET88c0yElzLkowAmPxULoAlOh/6qjlLzrZQSWRw8GtcA2HXjN3xniyRf7spcvwnd3dcHjWrg2pMCM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1701523868; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=akaY1Cc3buwwDmaZZe2QnK++1qth3tcZYbUf22uRfqk=; 
	b=CyqxJdvEYC7uXxL4cHZzXfmje8YtIlQClHGKsrVCZmsKYzQEdoAeeIRS03rFQ3vzVKLjy0UZPrKjtlrqV7MV6iEEzpET13JfzX4RTY1jGfIeSWtAFEX8BxshIqz7zflm0oxM7R7UmIEPs62k0U7m7a1wRyms+WoZJDpAltOJ7WU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701523868;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=akaY1Cc3buwwDmaZZe2QnK++1qth3tcZYbUf22uRfqk=;
	b=Pd5l3ydJ+7gmxCHEl8a4Z7HS6F2kWOwIoiq3YXICvmDVY+3gmuwPlmXyR4xlPXI5
	Jptm/eXIIDao68hmWpP4cc266qtJsrG3olt9TBl6Vz5CJTL6dmAfJsnwiF2EceMXlJ0
	drz2PWV2hZdcK6rGgoTdizErOtUVe0gtz4X3wlAU=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1701523836060470.24476872288676; Sat, 2 Dec 2023 19:00:36 +0530 (IST)
Date: Sat, 02 Dec 2023 19:00:36 +0530
From: Siddh Raman Pant <code@siddh.me>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"syzbot+bbe84a4010eeea00982d"
 <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Message-ID: <18c2ab94c79.3fa2cf6838735.1569409890067902989@siddh.me>
In-Reply-To: <0c35dd80-8062-4f1b-9127-8a5cb2deca40@linaro.org>
References: <cover.1700943019.git.code@siddh.me>
 <7c198c2aa08b34045b8f9e0afe3d0b3bf5802180.1700943019.git.code@siddh.me> <0c35dd80-8062-4f1b-9127-8a5cb2deca40@linaro.org>
Subject: Re: [PATCH 2/4] nfc: Protect access to nfc_dev in an llcp_sock with
 a rwlock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On Mon, 27 Nov 2023 16:08:16 +0530,  Krzysztof Kozlowski wrote:
> On 25/11/2023 21:26, Siddh Raman Pant wrote:
> > llcp_sock_sendmsg() calls nfc_llcp_send_ui_frame(), which accesses the
> > nfc_dev from the llcp_sock for getting the headroom and tailroom needed
> > for skb allocation.
> 
> This path should have reference to nfc device: nfc_get_device(). Why is
> this not sufficient?

The index needed for nfc_get_device() is inside nfc_dev itself.

Though now that I think about it, I should have modified the get and put
functions of llcp_local itself to hold the ref.

As you said, it looks like a band-aid with the extra lock. I agree.
Sorry about that.

> > Parallely, the nfc_dev can be freed via the nfc_unregister_device()
> > codepath (nfc_release() being called due to the class unregister in
> > nfc_exit()), leading to the UAF reported by Syzkaller.
> > 
> > We have the following call tree before freeing:
> > 
> > nfc_unregister_device()
> > 	-> nfc_llcp_unregister_device()
> > 		-> local_cleanup()
> > 			-> nfc_llcp_socket_release()
> > 
> > nfc_llcp_socket_release() sets the state of sockets to LLCP_CLOSED,
> > and this is encountered necessarily before any freeing of nfc_dev.
> 
> Sorry, I don't understand. What is encountered before freeing?

nfc_llcp_socket_release() setting of socket state to closed.

> > Thus, add a rwlock in struct llcp_sock to synchronize access to
> > nfc_dev. nfc_dev in an llcp_sock will be NULLed in a write critical
> > section when socket state has been set to closed. Thus, we can avoid
> > the UAF by bailing out from a read critical section upon seeing NULL.
> > 
> > [...]
> > 
> > @@ -102,6 +102,7 @@ struct nfc_llcp_local {
> >  struct nfc_llcp_sock {
> >  	struct sock sk;
> >  	struct nfc_dev *dev;
> > +	rwlock_t rw_dev_lock;
> 
> I dislike the idea of introducing the third (!!!) lock here. It looks
> like a bandaid for this one particular problem.

Yes, I see it now. Sorry about that.

> > +		pr_err("NFC device does not exit\n");
> 
> exist?

Ouch, yes.

I'll send a v2 improving the things.

Thanks,
Siddh

