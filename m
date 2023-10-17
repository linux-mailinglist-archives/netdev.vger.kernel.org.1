Return-Path: <netdev+bounces-41725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327BC7CBC79
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A94AB20FCA
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CB1F5FA;
	Tue, 17 Oct 2023 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ay60W9zo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708854404;
	Tue, 17 Oct 2023 07:41:52 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E18F;
	Tue, 17 Oct 2023 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697528507; x=1697787707;
	bh=Dkzy2YiSbGk0eaGP2EwvSNner+nDvIC06gMS1dbmlLw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ay60W9zo7wjxjiCtueS+JoGsMjVnWq1ItmSEnCYC2wAnr12waEco1Qih1RwgJnxDH
	 VstWBy3wnlODKhqqdijpz7pktkAOErsMFFgIIO4d7Z3OKPF2eMMHEa9kys/ENRPGtM
	 CUUMk6xRF5UdodriWQGN1QRWBi9DS74Zm4pAMfjlSoMk4fOwq3/4qWHFFqN+LLeMaU
	 zDvtblBQipsNECPiYfx7jPiGGY7ERmZKjzsgdBYQaMz4gsf/lzA9GA/uv5GfAFtAlp
	 kGN1fV9azu0dcJ7VeisJk4FyM79kdERSVsJe4m8d7QXW8DkcxHVgksC7PxrKNheAig
	 VAF45RbN1xvjg==
Date: Tue, 17 Oct 2023 07:41:38 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
Message-ID: <cad79d65-4c66-4344-b0b4-93d2cbf891af@proton.me>
In-Reply-To: <20231017.163249.1403385254279967838.fujita.tomonori@gmail.com>
References: <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me> <20231015.073929.156461103776360133.fujita.tomonori@gmail.com> <98471d44-c267-4c80-ba54-82ab2563e465@proton.me> <20231017.163249.1403385254279967838.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17.10.23 09:32, FUJITA Tomonori wrote:
> On Tue, 17 Oct 2023 07:06:38 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>>> Secondly, What's the difference between read() and write(), where you
>>> think that read() is &self write() is &mut self.
>>
>> This is just the standard Rust way of using mutability. For reading one
>> uses `&self` and for writing `&mut self`. The only thing that is special
>> here is the stats that are updated. But I thought that it still could fi=
t
>> Rust by the following pattern:
>> ```rust
>>       pub struct TrackingReader {
>>           buf: [u8; 64],
>>           num_of_reads: Mutex<usize>,
>>       }
>>
>>       impl TrackingReader {
>>           pub fn read(&self, idx: usize) -> u8 {
>>               *self.num_of_reads.lock() +=3D 1;
>>               self.buf[idx]
>>           }
>>       }
>>
>> ```
>>
>> And after taking a look at `mdiobus_read` I indeed found a mutex.
>=20
> Yes, both read() and write() update the stats with mdiobus's lock.
>=20
>=20
>>> read() is reading from hardware register. write() is writing a value
>>> to hardware register. Both updates the object that phy_device points
>>> to?
>>
>> Indeed, I was just going with the standard way of suggesting `&self`
>> for reads, there are of course exceptions where `&mut self` would make
>> sense. That being said in this case both options are sound, since
>> the C side locks a mutex.
>=20
> I see. I use &mut self for both read() and write().

I would recommend documenting this somewhere (why `read` is `&mut`), since
that is a bit unusual (why restrict something more than necessary?).

--=20
Cheers,
Benno



