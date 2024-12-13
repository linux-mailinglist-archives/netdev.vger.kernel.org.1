Return-Path: <netdev+bounces-151826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863179F11DD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E430B1888E48
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAE5186294;
	Fri, 13 Dec 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="DrNbldMN"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C531632FE
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106518; cv=none; b=UBEIM68b5L+mM3xt8TloNmabSMug4WhmPxOvjkQ7pzrCUWiA3gBgQMDe4sQbzvXCkWDawvMlr5cV/u27fuVvtYoDt2wSODalmnSjZZj5FZS3pvV1OOrNwcb6f47iKZ8n1WVL5o9hvvib6tCgldFmt3Ru88ASiX9h5YLZOM6qobM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106518; c=relaxed/simple;
	bh=hoBRX+18J5b/FO0rrJBZMI5+6uYLOYETcgsqENlI2LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQ949XM2bCffkxmd6S0f05uCVaa7/wIU5CsnTh50nXO+CNKhEuWuKcEfg4zu4qxiPhyXzuPoQ4IZh+86t9IMQ6CaQjB3nuCXSDBoND29mctB5iQv88X3qsYHPWmyaoDyFMWY+fQSEs9IzK50Hvwq2jP2pqQI+4pE96krN7tp0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=DrNbldMN; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tM8Jo-007bCn-8l
	for netdev@vger.kernel.org; Fri, 13 Dec 2024 17:15:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=EgZiJtQ4Z0CZl+BDiFk5+uaN0gqF99Q9cF4x9N3VU6A=; b=DrNbldMNYAEokw7QtzFJDQXWRu
	RdYYsmNhkcmOvAovPEttI/h/YJNqwz14ahK43Ilc154zSRjlMxfjmFp9oa2mBeXP821hdoDjp213Q
	EPP1vuHqeE0D3/ArXOG9t8Lm7ZIeU2UGS/MH2phpiQEbS/zGQDwkxuUZVTydDqDUcQqiuEGiWMTik
	2jGfaobnSGxg1d5/Lnp/G5BRpR19DW+zWF9eAY9DGlFEJat4WxbyOIzMa4Wd+o8ppRBtcPnErjxOy
	QBt/mredhNf/bsDH0ISuKqpn4bwKqvEBDnH4OBVjteE2w7oquTvep3uNvr2NldT0Q7xLJoU4tzCj6
	yE20YvLw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tM8Jn-0001Ga-CP; Fri, 13 Dec 2024 17:15:07 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tM8Jj-00DxLP-Qx; Fri, 13 Dec 2024 17:15:03 +0100
Message-ID: <bff25039-1cba-4af9-9f6b-93bc0179fb92@rbox.co>
Date: Fri, 13 Dec 2024 17:15:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] vsock/test: Add test for accept_queue memory
 leak
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-2-c31e8c875797@rbox.co>
 <uyzzicjukysdqzf5ls5s5qp26hfqgrwjz4ahbnb6jp36lzazck@67p3eejksk56>
 <a8fa27ad-b1f5-4565-a3db-672f5b8a119a@rbox.co>
 <jep457tawmephttltjbohtqx57z63auoshgeolzhacz7j7rwra@z2uqfegja6dm>
 <0bf61281-b82c-4699-9209-bf88ea9fdec5@rbox.co>
 <ghjvsagimzpok2ybcuo35t2bny3qsewl5xnbepur3b7f46ka6n@7horausgutui>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <ghjvsagimzpok2ybcuo35t2bny3qsewl5xnbepur3b7f46ka6n@7horausgutui>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 15:47, Stefano Garzarella wrote:
> On Fri, Dec 13, 2024 at 03:27:53PM +0100, Michal Luczaj wrote:
>> On 12/13/24 12:55, Stefano Garzarella wrote:
>>> On Thu, Dec 12, 2024 at 11:12:19PM +0100, Michal Luczaj wrote:
>>>> On 12/10/24 17:18, Stefano Garzarella wrote:
>>>>> [...]
>>>>> What about using `vsock_stream_connect` so you can remove a lot of
>>>>> code from this function (e.g. sockaddr_vm, socket(), etc.)
>>>>>
>>>>> We only need to add `control_expectln("LISTENING")` in the server which
>>>>> should also fix my previous comment.
>>>>
>>>> Sure, I followed your suggestion with
>>>>
>>>> 	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
>>>> 	do {
>>>> 		control_writeulong(RACE_CONTINUE);
>>>> 		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>>> 		if (fd >= 0)
>>>> 			close(fd);
>>>
>>> I'd do
>>> 		if (fd < 0) {
>>> 			perror("connect");
>>> 			exit(EXIT_FAILURE);
>>> 		}
>>> 		close(fd);
>>
>> I think that won't fly. We're racing here with close(listener), so a
>> failing connect() is expected.
> 
> Oh right!
> If it doesn't matter, fine with your version, but please add a comment
> there, otherwise we need another barrier with control messages.
>
> Or another option is to reuse the control message we already have to
> close the previous listening socket, so something like this:
> 
> static void test_stream_leak_acceptq_server(const struct test_opts *opts)
> {
> 	int fd = -1;
> 
> 	while (control_readulong() == RACE_CONTINUE) {
> 		/* Close the previous listening socket after receiving
> 		 * a control message, so we are sure the other side
> 		 * already connected.
> 		 */
> 		if (fd >= 0)
> 			close(fd);
> 		fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
> 		control_writeln("LISTENING");
> 	}
> 
> 	if (fd >= 0)
> 		close(fd);
> }

I'm afraid this won't work either. Just to be clear: the aim is to attempt
connect() in parallel with close(listener). It's not about establishing
connection. In fact, if the connection has been established, it means we
failed reaching the right condition.

In other words, what I propose is:

client loop		server loop
-----------		-----------
write(CONTINUE)
			expect(CONTINUE)
			listen()
			write(LISTENING)
expect(LISTENING)
connect()		close()			// bang, maybe

And, if I understand correctly, you are suggesting:

client loop		server loop
-----------		-----------
write(CONTINUE)
			expect(CONTINUE)
			listen()
			write(LISTENING)
expect(LISTENING)
connect()					// no close() to race
// 2nd iteration
write(CONTINUE)
			// 2nd iteration
			expect(CONTINUE)
			close()			// no connect() to race
			listen()
			write(LISTENING)
expect(LISTENING)
connect()					// no close() to race

Hope it makes sense?


