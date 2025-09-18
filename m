Return-Path: <netdev+bounces-224553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3303EB86120
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3E1481274
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B9630F958;
	Thu, 18 Sep 2025 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LnQKRMBa"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-21.consmr.mail.ne1.yahoo.com (sonic304-21.consmr.mail.ne1.yahoo.com [66.163.191.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB4225A3B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213680; cv=none; b=Xtw4MtFR1d9vYgxknrTVZjZzZIzBJAX60us/QWY5KFQ4DZaHDuJ4QEN/7WCH6Zi+GuRfA/ba3s9lOrvbCn5lA8iGQ3slfD18supSqEUXUQXv3fxHrm6gnHcQZ6izxzj45Tpz8krt3//5HehuG87OwdU0O8H5nseBKiQJxdzDrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213680; c=relaxed/simple;
	bh=gGbzZ5VV3OIn62Eu6iZwDqNaFqwL/+7x16wU9sQnAis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTn2MLLDP+SzdG2vgrAuVN6WIul4O2BIl5CqooMrC/oDoSWpc/fkO3NgyRU5fs2cpHB+tJnCgELFZSNgRZu4/LVxjZRHjDK2dD0GOxCF9ghRRYKe0B/m+NzI3578FyVF560IjFGw04TGJpHj1imRiBu8KxanQ8vfmh4jsIeFtNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LnQKRMBa; arc=none smtp.client-ip=66.163.191.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758213678; bh=/4PcM/wn+07Mm2majPeVM3gZSggh73UfIq3Vf1R81K4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LnQKRMBaxEkuhGbh4ME2CRnJnN8lWMl5FJFzE6iuh+J+nmED0V2SOdZlcIFgDP/dEQ5eOtC17ZV2QnXM1+L6acExm3itEs0uVPPOZAR+PCye+8akXVWnABpOubSnYzPzqcoCxitcet+jkQwdHjgDg19oynHtc8MnuYCJJpLqw71+8PnQB4/juEq4Pw4foRY1SRMLbkND87BQJWbTgoBQilOtH4wu4MV1Nq2Qgz80ec5DX1acJBF9q2y+Yv5sA9YBcjvw+EQW/guhCOXpKc7oEgU1uCYIEN0LVzT0/w+e96s6ry8TFI5llM5qD/3RDjJh2FRmQtO4Gjsd77RwCM7ytg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758213678; bh=OHboz8RJa4KPoMxgbHWMtzOo7Se50Q2WBrR33eEn/Qr=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IShDeQHdoGVoVpHnz04yzCg7Z163i9B/qvmeYcSSzSjEW9GIdLaRf+0OhFobnSDZeaGAlGSQMOgfc+Z1R2/Oz67TlFvVVVlD0CzFLy3arcYZx9jCXMTog659ojdXhmfmmjizXU1xxi2sMdYqyE4Ctf8B9UZoeTpYst9iRHjha0kFYlOLDNRJ41aabglhsiUBDeM7qJEXsyRLLA3G4t4JBtb9yT5Gak5oy+NgyKjKWHzFathgrB65ztc6wqM6odYgkUeSRbWOqxJMMOm+hxtYra7D2DeZHHLUJXzEjYjxc+AjExjlfHEGbrm+Qyh3CFCjgC4733ZgslJq6tAjU5/qzQ==
X-YMail-OSG: VjE47V0VM1nbbQNsYV50AfhTgVZU2F0oItBNFEpxLT8Hm9iYgMoT_5JiDdRJGtY
 ZhHjGyaW9npSenBg92Vu5r_wseSK1MkjYOXivGTJvS9v6f4pY4VwpVXpk8TzxMLc_Yb.VbEWvAd.
 9iJV7QvaiBWtLRY5pdN1uYmxouo898fDPGowBrg6mLxHszoeACITfKUjG1QRC.eRjDhqtoAKDear
 TncGTkzmP2TcEoZK5cpE8qk1jL86QPXzbpfub2od0R7JvB2OJdqUYHs0tkoHLYPIJAgkC2bqbcjR
 57KS.TRo4ea3RZtaj62jwEvCIhT087xfWgLuS74zK_BgNl9L_MrseH1BhwlJy8za7Dh61o22LXnY
 leH8UglTLFoFVFvbQ71oNXchOJZ51PIRJ9Bs_3Uz9ReWhprUsf3wqhWJJLYB0YVAFa.2aFfPE5BA
 euYj13cFBLIBS2giHSqNuxyHLTJsS5p7xuurMJE8x.hb0QjFb9ZHkS1hMNKDlFfk4lwRXXKl2Ym1
 5KjKs0OmcwZKKeRTbdL19xvfZ_nwMKMRz_eh4E2vvQvPSU5Fc828BNS70ypkLNNahiFG7aK6J_6S
 mFTWcJclaiVZ4GCnRqz9_6ynVVLfv9PntuhbcVLEoxcUGJZlIrLc.WAQZ5LU5ngYtdP2TVV8T8Oc
 TkWmjlE6IHZv63nZOEyE.rpueIrL7IgcVBbx__URDSmpTRQzMfsgBvoe.cHBlrPb.Wj3n1cyoKxx
 XFWTeRsFyHVErbYVaYCQcJs5ogwUcMkxgPUxvI8cPbA4rwGRhFB1FsB49D0zt.bZssawCk0XvmQT
 hO2SLrImY214R8arsXJEOo3IFYtZheIqzfcwfFdaHa5wg5HtyjvI2iF6W36WVSqbf5QqvZpiE33X
 cUzF8d1jbSb3lDeJ7cXrjltIDiZVqlP5FwMUl.8I7B8ut74Km5AbHtlmhl4iH8svf2jreiw.YImZ
 vFb7TicZv3NbVCHVCsafpjSVGX0ayvQyUhaacNH6UPjNScWx5nkch2ByFiO.jF_pNl3bNe2bBm0N
 uiPSzQIJtwsANAX_2i_5zt55Ck987XD2UpBddGUuP3l2UXzwLzwrusMOXxm27WTxEKZ.R6xEVBIv
 1r.Mq.q_MpfqIs4k2KeMM5TTE3M_bt0THPebacoE2tYqt_HDAf7KFA9MS1.dLAAN.hK6j8pZIlW6
 CDDOuYqp.o2QFU4id_VND34yCWTCZMuuVUej7Q3D9self5Xc2eazy4V3tfIiX9szvfNbcRW0Kn0R
 WbLLJLa3NvFtyH_TE03MS.802gChBG1bHBM_HZAtkKvzaZmMciRdhm7mtfp8H0uSGndy2y7d2jr7
 v5MP7CmSr2vAADZiYtyf9VATfBVVfmwPvDh4Ihh8Q0GCrnWPrwq1ltrrav8yP.TPHsbog4j1UuTd
 pV.vA_dIlaGC6FG.NsAxc_vOzwiLT8zTR5dti8D8Uceby7Mwzht7EtcRMoWAVB_YE.Sw2dF_gTNV
 tQJFgV5pqa_qnHMBh9Ly0ezekBPdbYkm_mzNNW50.vOnlFwPQVkaWW_A63hNS96cJOJO6RxmVuAd
 RE0p2wtxbllhGzJfT3UImuaSTuAUUIhYgGQ5elgiSqaWXk16J2IDwza6sqQPQ6T8rsNk8iL6O_wW
 RjH3tfFno8IVON__6typfobuPn5XX0Wgiy94j8ZapKBot1LjcMO0RJsnhbsnHzNw0OkFCxT8xLiV
 gd2zI.EY3liT5xzUemy.Z1iSFDhShOvS2V5.dCkc.O4QULBv0vQS4LfB0bsB2yzW_KG7A5OoWNOg
 wiiUsEE.UEKbo7DAFxSh4FhIZKqeX4kV5bSHvJgTB.KHdlsc6jw8KfR1Tv07_ZMfEAaf1lFwoAOs
 a3hyCESfOi6x4Rcfpk4x.mzV_831Oc6RaQ2A7lpOWf5os_q0weWfH5EnmdK44WeN2rJJN7rv1XFa
 vhmAjpwv8c8.X8hy56LbNANfIRl2VooYQRt1mCYt9eCWN5JUdL0RkTEDSDSopRuRZnW7w_xbrEvc
 DlnHWN_WDaEQtzfJzLDieNfpV6EnRoUyIm1aBMqpY3d2pP.IefvF9I2ZRafUM1cAxvzhtUsA2Lak
 UFLQTh5bik4MoSeA46zcI3YrecviVOMO6CP2JlFVRq4J2UZcO_t08EB0wO6LqCS3OkEzL9z3e4__
 YbTuAYtgaqD3KBlVxAhURcQGPZ842kPrQEaqNcX7B
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: a098bdce-3a02-4107-ab3b-992d6f1a8803
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 Sep 2025 16:41:18 +0000
Received: by hermes--production-ir2-74585cff4f-g8xqt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 66fa4a894ced73a43e3b3b871bfd45cf;
          Thu, 18 Sep 2025 16:31:06 +0000 (UTC)
Message-ID: <c17df80c-35ba-4671-8cf2-e54e72da2374@yahoo.com>
Date: Thu, 18 Sep 2025 18:31:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: tunnel: introduce noref xmit flows for
 tunnels
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
 openvpn-devel@lists.sourceforge.net
References: <20250909054333.12572-1-mmietus97.ref@yahoo.com>
 <20250909054333.12572-1-mmietus97@yahoo.com>
 <b8b604f7-c5c3-4257-93da-8f6881e96fe4@openvpn.net>
 <8e6b83b3-c986-4d6e-b61a-363e13bf1ddc@yahoo.com> <aMk_U3zeHviJC1GI@krikkit>
Content-Language: en-US
From: Marek Mietus <mmietus97@yahoo.com>
In-Reply-To: <aMk_U3zeHviJC1GI@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24425 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

W dniu 9/16/25 o 12:43, Sabrina Dubroca pisze:
> 2025-09-09, 16:43:01 +0200, Marek Mietus wrote:
>> W dniu 9/9/25 o 13:17, Antonio Quartulli pisze:
>>> On 09/09/2025 07:43, Marek Mietus wrote:
>>>> Currently, all xmit flows use dst_cache in a way that references
>>>> its dst_entry for each xmitted packet. These atomic operations
>>>> are redundant in some flows.
>>>
>>> Can you elaborate on the current limits/drawbacks and explain what we gain with this new approach?
>>>
>>> It may be obvious for some, but it's not for me.
>>>
>>
>> The only difference with the new approach is that we avoid taking an unnecessary
>> reference on dst_entry. This is possible since the entire flow is protected by RCU.
>> This change reduces an atomic write operation on every xmit, resulting in a performance
>> improvement.
> 
> It would be nice to incorporate this information into the cover
> letter, and to provide numbers showing the performance
> improvement. That way, it's available to other reviewers and gets
> recorded in the git log. Are you doing crypto with some accelerator?
> Otherwise I'd imagine skipping a few atomic operations is not really
> noticeable.
> 
>> There are other flows in the kernel where a similar approach is used (e.g. __ip_queue_xmit
>> uses skb_dst_set_noref).
>>
>>> Also it sounded as if more tunnels were affected, but in the end only ovpn is being changed.
>>> Does it mean all other tunnels don't need this?
>>>
>>
>> More tunneling code can be updated to utilize these new helpers. I only worked
>> on OpenVPN, as I am more familiar with it. It was very easy to implement the
>> changes in OpenVPN because it doesn't use the udp_tunnel_dst_lookup helper
>> that adds some complexity.
>>
>> I hope to incorporate these changes in more tunnels in the future.
> 
> It would also be good to add this to the cover letter. Something like
> "For now, only ovpn is updated <for $reason>, but other tunnels could
> also take advantage of this."
> 

Noted, will add in the next revision.

