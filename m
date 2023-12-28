Return-Path: <netdev+bounces-60488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1986381F841
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 13:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AF41F23211
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B387499;
	Thu, 28 Dec 2023 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfYc7rQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B8748D
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2358a75b69so1040213366b.1
        for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 04:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703768219; x=1704373019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ynkZbcWwsZ6+Yd9tdRq4a0/2KqWy9WnKXBsTPM8ZszQ=;
        b=QfYc7rQXAaMmauKk2rfGsc0G184bCC/61bKawimpnBOyl6qVIp6HP6YNbp6Aw9GNbt
         UnHPyzBEXjS7PutQtrrIkgLNIcom/jttDpE0lDmYnmd6wyHPrT/xrr3HTs8LLjG46X2p
         48gPCJqdbx0aapuHWruLDISMwP/0SaY3dg8vtLI4voxPKgKbXazAOKZMbUN3iwZ/mH5m
         SVXL8k9rUc2BK01LTFvy6T2nW6YpowmnQKnXqS1SXr5NzaPaQ0VZIGvUYFwFMZUwEQyE
         r+tdxc5EcgrLVLtG3BQgCzE5rAkRWd/IQjLiJhciVdmatcmHvS4RZLrwlKnx6/bg8ILp
         wjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703768219; x=1704373019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynkZbcWwsZ6+Yd9tdRq4a0/2KqWy9WnKXBsTPM8ZszQ=;
        b=fruudjaoL2A4/OmEN4KAfiLsaE4ETDxty9wjH1kbZA/NTUZiOgUDyOzLXdbnA2Yq7d
         NyQtPEpjQvy905ooZEEIBJl6Tg8mfo5/ClpDCDJBZsW4qC7jd2eMlcvMrpZZvnzhzEgo
         hHM6p1z7t/rfKYTmnWoek7n9DV6CiBd7LsM5H53yXlfg/Ntr0qQxu3XZMxWCeM6m4J8z
         XB5H00l/lnJOVqt13xGCTOY5vuQc1j3QKkEJLaN2JZGL5BXCXLY0w+My2GFOFLeOOaOh
         LQFuyhLpvnqQWtNyC/DLU3T2UypkJV9c8AEi03FhhMjDeUfRgOGPRqomuiOModSOzDQ+
         +Lnw==
X-Gm-Message-State: AOJu0Yx1MN5z139FMzZK05lhGE9KWrxAyPhqnvC+EJzJG8NDgUxh6aXt
	pNevOCAguzwQuxa99XepLoUCpDVMVLBgoU6KNfvj7CebZS57gg==
X-Google-Smtp-Source: AGHT+IHcW4W+qhCv9ZsiN6RbVepn7zRo6hGcTrU9LTM8HPc9+s1+PficzowzB5YfrtBf8poKgi24unbC2MqIBtBS1ZU=
X-Received: by 2002:a17:906:c7c6:b0:a1c:a542:2fcb with SMTP id
 dc6-20020a170906c7c600b00a1ca5422fcbmr7742853ejb.31.1703768218501; Thu, 28
 Dec 2023 04:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <55c522f9-503e-4adf-84cc-1ccc1fb45a9b@broadcom.com>
 <20231227120601.735527-1-adriancinal1@gmail.com> <4b3d4c59-70d8-41b7-954e-8f7294026516@gmail.com>
 <CAPxJ3Bd1hPpAMXs1-o3CQcQ2H3XTaH_Z4GEpfvAa-0XnZMS0Xg@mail.gmail.com> <490c4671-608f-489b-963a-a42ca839c404@broadcom.com>
In-Reply-To: <490c4671-608f-489b-963a-a42ca839c404@broadcom.com>
From: Adrian Cinal <adriancinal1@gmail.com>
Date: Thu, 28 Dec 2023 13:56:45 +0100
Message-ID: <CAPxJ3Bdo9jO_UuA2V1p7sTTdcObGC8VtufDu_ce3ecSF47JpHw@mail.gmail.com>
Subject: Re: [PATCH v2] net: bcmgenet: Fix FCS generation for fragmented skbuffs
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Doug Berger <opendmb@gmail.com>, netdev@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: multipart/mixed; boundary="00000000000071a0de060d917344"

--00000000000071a0de060d917344
Content-Type: text/plain; charset="UTF-8"

I attach a minimal reproducible example (largely inspired by
https://github.com/OpenDataPlane/odp/blob/master/platform/linux-generic/pktio/socket_mmap.c).
It sets up the "Packet MMAP" interface to the kernel and sends a
single broadcast frame.

If payload_size (parsed from argv[2]) is smaller than 46, then

    payload_size + sizeof(struct ether_header) + sizeof(struct llc_header) < 64

and the receiver sees a runt packet (without DMA_TX_APPEND_CRC in the
last descriptor
padding to 64 bytes is not performed either). Otherwise the packet is
rejected on the
grounds of bad (actually missing) CRC.

gcc bcmgenet_mre.c
./a.out end0 40  -->  runt packet
./a.out end0 50  -->  bad CRC

--
Adrian

On Thu, 28 Dec 2023 at 09:25, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
>
>
> On 12/28/2023 9:10 AM, Adrian Cinal wrote:
> > On Wed, 27 Dec 2023 at 21:39, Doug Berger <opendmb@gmail.com> wrote:
> >>
> >> On 12/27/2023 4:04 AM, Adrian Cinal wrote:
> >>> The flag DMA_TX_APPEND_CRC was written to the first (instead of the last)
> >>> DMA descriptor in the TX path, with each descriptor corresponding to a
> >>> single skbuff fragment (or the skbuff head). This led to packets with no
> >>> FCS appearing on the wire if the kernel allocated the packet in fragments,
> >>> which would always happen when using PACKET_MMAP/TPACKET
> >>> (cf. tpacket_fill_skb() in af_packet.c).
> >>>
> >>> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> >>> Signed-off-by: Adrian Cinal <adriancinal1@gmail.com>
> >>> ---
> >>>    drivers/net/ethernet/broadcom/genet/bcmgenet.c | 10 +++++-----
> >>>    1 file changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> >>> index 1174684a7f23..df4b0e557c76 100644
> >>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> >>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> >>> @@ -2137,16 +2137,16 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>                len_stat = (size << DMA_BUFLENGTH_SHIFT) |
> >>>                           (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT);
> >>>
> >>> -             /* Note: if we ever change from DMA_TX_APPEND_CRC below we
> >>> -              * will need to restore software padding of "runt" packets
> >>> -              */
> >>>                if (!i) {
> >>> -                     len_stat |= DMA_TX_APPEND_CRC | DMA_SOP;
> >>> +                     len_stat |= DMA_SOP;
> >>>                        if (skb->ip_summed == CHECKSUM_PARTIAL)
> >>>                                len_stat |= DMA_TX_DO_CSUM;
> >>>                }
> >>> +             /* Note: if we ever change from DMA_TX_APPEND_CRC below we
> >>> +              * will need to restore software padding of "runt" packets
> >>> +              */
> >>>                if (i == nr_frags)
> >>> -                     len_stat |= DMA_EOP;
> >>> +                     len_stat |= DMA_TX_APPEND_CRC | DMA_EOP;
> >>>
> >>>                dmadesc_set(priv, tx_cb_ptr->bd_addr, mapping, len_stat);
> >>>        }
> >> Hmm... this is a little surprising since the documentation is actually
> >> pretty specific that the hardware signal derived from this flag be set
> >> along with the SOP signal.
> >>
> >> Based on that I think I would prefer the flag to be set for all
> >> descriptors of a packet rather than just the last, but let me look into
> >> this a little further.
> >>
> >> Thanks for bringing this to my attention,
> >>       Doug
> >
> > Hello,
> >
> > I confirm that it works just as well when the flag is set for all
> > descriptors rather than just the last. Tested on a BCM2711.
>
> Could you share how you triggered the problematic path? Thanks!
> --
> Florian

--00000000000071a0de060d917344
Content-Type: text/x-csrc; charset="US-ASCII"; name="bcmgenet_mre.c"
Content-Disposition: attachment; filename="bcmgenet_mre.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lqp7hhoq0>
X-Attachment-Id: f_lqp7hhoq0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0ZGxpYi5o
PgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxz
eXMvaW9jdGwuaD4KI2luY2x1ZGUgPG5ldC9pZi5oPgojaW5jbHVkZSA8bmV0aW5ldC9ldGhlci5o
PgojaW5jbHVkZSA8YXJwYS9pbmV0Lmg+CiNpbmNsdWRlIDxsaW51eC9pZl9wYWNrZXQuaD4KI2lu
Y2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGFzc2VydC5o
PgoKI2RlZmluZSBNVFUgICAgICAgICAgICAgICAgICAgMTUwMAojZGVmaW5lIEZSQU1FX01FTV9T
SVpFICAgICAgICAoIDQgKiAxMDI0ICogMTAyNCApCiNkZWZpbmUgQkxPQ0tfU0laRSAgICAgICAg
ICAgICggNCAqIDEwMjQgKQoKdHlwZWRlZiB1aW50OF90IHU4Owp0eXBlZGVmIHVpbnQxNl90IHUx
NjsKdHlwZWRlZiB1aW50MzJfdCB1MzI7CgpzdHJ1Y3QgcmluZyB7CiAgICBpbnQgc29jazsKICAg
IGludCB0eXBlOwogICAgaW50IHZlcnNpb247CiAgICB2b2lkICoqIGZyYW1lczsKICAgIHNpemVf
dCBmcmFtZV9udW07CiAgICBzaXplX3QgZnJhbWVfY291bnQ7CiAgICB2b2lkICogbW1hcF9iYXNl
OwogICAgc2l6ZV90IG1tYXBfbGVuOwogICAgc2l6ZV90IGZyYW1lX2xlbmd0aDsKICAgIHN0cnVj
dCB0cGFja2V0X3JlcSB0cGFja2V0X3JlcTsKfTsKCnN0cnVjdCBsbGNfaGVhZGVyIHsKICAgIHU4
IGRzYXA7CiAgICB1OCBzc2FwOwogICAgdTE2IGNvbnRyb2w7Cn07CgpzdGF0aWMgaW5saW5lIHZv
aWQgZ2V0X293bl9tYWMoY29uc3QgY2hhciAqIGlmX25hbWUsIHU4IG1hY1s2XSk7CnN0YXRpYyBp
bmxpbmUgdm9pZCBzZXR1cF9yaW5nKHN0cnVjdCByaW5nICogcmluZywgaW50IHNvY2ssIGludCB0
eXBlKTsKc3RhdGljIGlubGluZSB2b2lkIHNlbmRfYnJvYWRjYXN0X3BhY2tldChzdHJ1Y3Qgcmlu
ZyAqIHR4X3JpbmcsIHNpemVfdCBwYXlsb2FkX3NpemUsIHU4IHNlbmRlcl9tYWNbNl0pOwpzdGF0
aWMgaW5saW5lIHUzMiByb3VuZF91cF90b19wb3dfMih1MzIgeCk7CgppbnQgbWFpbiAoaW50IGFy
Z2MsIGNoYXIgKiphcmd2KSB7CgogICAgaWYgKGFyZ2MgPCAzKSB7CiAgICAgICAgcHJpbnRmKCJ1
c2FnZTogJXMgPGludGVyZmFjZSBuYW1lPiA8cGF5bG9hZCBzaXplPlxuIiwgYXJndlswXSk7CiAg
ICAgICAgZXhpdChFWElUX0ZBSUxVUkUpOwogICAgfQoKICAgIGNvbnN0IGNoYXIgKiBpZl9uYW1l
ID0gYXJndlsxXTsKICAgIHU4IG93bl9tYWNbNl07CiAgICBnZXRfb3duX21hYyhhcmd2WzFdLCBv
d25fbWFjKTsKCiAgICBjaGFyICogZW5kcHRyID0gTlVMTDsKICAgIHNpemVfdCBwYXlsb2FkX3Np
emUgPSBzdHJ0b2woYXJndlsyXSwgJmVuZHB0ciwgMCk7CiAgICAvKiBFbnN1cmUgYSBudW1iZXIg
d2FzIHBhcnNlZCAqLwogICAgYXNzZXJ0KGVuZHB0ciAhPSBhcmd2WzJdKTsKCiAgICAvKiBPcGVu
IGEgcmF3IHNvY2tldCAqLwogICAgaW50IHNvY2sgPSBzb2NrZXQoUEZfUEFDS0VULCBTT0NLX1JB
VywgaHRvbnMoRVRIX1BfQUxMKSk7CiAgICBhc3NlcnQoc29jayAhPSAtMSk7CiAgICAvKiBVc2Ug
VFBBQ0tFVF9WMiAqLwogICAgaW50IHZlciA9IFRQQUNLRVRfVjI7CiAgICAodm9pZCkgc2V0c29j
a29wdChzb2NrLCBTT0xfUEFDS0VULCBQQUNLRVRfVkVSU0lPTiwgJnZlciwgc2l6ZW9mKHZlcikp
OwogICAgc3RydWN0IHNvY2thZGRyX2xsIHNhID0gewogICAgICAgIC5zbGxfZmFtaWx5ID0gUEZf
UEFDS0VULAogICAgICAgIC5zbGxfcHJvdG9jb2wgPSBodG9ucyhFVEhfUF9BTEwpLAogICAgICAg
IC5zbGxfaWZpbmRleCA9IGlmX25hbWV0b2luZGV4KGlmX25hbWUpCiAgICB9OwogICAgLyogQmlu
ZCB0aGUgc29ja2V0IHRvIGEgbmV0d29yayBkZXZpY2UgKi8KICAgICh2b2lkKSBiaW5kKHNvY2ss
IChjb25zdCBzdHJ1Y3Qgc29ja2FkZHIgKikgJnNhLCBzaXplb2Yoc2EpKTsKCiAgICAvKiBTZXQg
dXAgdGhlIHJpbmdzIGluIHRoZSBrZXJuZWwgKi8KICAgIHN0cnVjdCByaW5nIHR4X3Jpbmc7CiAg
ICBzdHJ1Y3QgcmluZyByeF9yaW5nOwogICAgc2V0dXBfcmluZygmdHhfcmluZywgc29jaywgUEFD
S0VUX1RYX1JJTkcpOwogICAgc2V0dXBfcmluZygmcnhfcmluZywgc29jaywgUEFDS0VUX1JYX1JJ
TkcpOwoKICAgIC8qIE1hcCBib3RoIHJpbmdzIGludG8gdXNlcnNwYWNlIGluIG9uZSBtbWFwKCkg
Y2FsbCAqLwogICAgc2l6ZV90IG1tYXBfbGVuID0gcnhfcmluZy5tbWFwX2xlbiArIHR4X3Jpbmcu
bW1hcF9sZW47CiAgICB2b2lkICogbW1hcF9iYXNlID0gbW1hcChOVUxMLCBtbWFwX2xlbiwgUFJP
VF9SRUFEIHwgUFJPVF9XUklURSwgXAogICAgICAgIE1BUF9TSEFSRUQgfCBNQVBfTE9DS0VEIHwg
TUFQX1BPUFVMQVRFLCBzb2NrLCAwKTsKICAgIGFzc2VydChtbWFwX2Jhc2UgIT0gTUFQX0ZBSUxF
RCk7CgogICAgLyogUlggcmluZyBpcyBmaXJzdCBpbiB0aGUgbWFwcGVkIG1lbW9yeSwgZm9sbG93
ZWQgYnkgdGhlIFRYIHJpbmcgKi8KICAgIHJ4X3JpbmcubW1hcF9iYXNlID0gbW1hcF9iYXNlOwog
ICAgdHhfcmluZy5tbWFwX2Jhc2UgPSBtbWFwX2Jhc2UgKyByeF9yaW5nLm1tYXBfbGVuOwoKICAg
IC8qIFNldCB1cCB0aGUgcG9pbnRlcnMgKi8KICAgIGZvciAoc2l6ZV90IGkgPSAwOyBpIDwgcnhf
cmluZy5mcmFtZV9jb3VudDsgaSsrKQogICAgICAgIHJ4X3JpbmcuZnJhbWVzW2ldID0gcnhfcmlu
Zy5tbWFwX2Jhc2UgKyAoaSAqIHJ4X3JpbmcuZnJhbWVfbGVuZ3RoKTsKICAgIGZvciAoc2l6ZV90
IGkgPSAwOyBpIDwgdHhfcmluZy5mcmFtZV9jb3VudDsgaSsrKQogICAgICAgIHR4X3JpbmcuZnJh
bWVzW2ldID0gdHhfcmluZy5tbWFwX2Jhc2UgKyAoaSAqIHR4X3JpbmcuZnJhbWVfbGVuZ3RoKTsK
CiAgICBzZW5kX2Jyb2FkY2FzdF9wYWNrZXQoJnR4X3JpbmcsIHBheWxvYWRfc2l6ZSwgb3duX21h
Yyk7CgogICAgcmV0dXJuIDA7Cn0KCnN0YXRpYyBpbmxpbmUgdm9pZCBnZXRfb3duX21hYyhjb25z
dCBjaGFyICogaWZfbmFtZSwgdTggbWFjWzZdKSB7CgogICAgLyogT3BlbiBhbnkgc29ja2V0IGFz
IGEgY2hhbm5lbCB0byB0aGUga2VybmVsICovCiAgICBpbnQgc29jayA9IHNvY2tldChBRl9JTkVU
LCBTT0NLX0RHUkFNLCAwKTsKICAgIGFzc2VydChzb2NrICE9IC0xKTsKICAgIC8qIEdldCB0aGUg
SFcgYWRkcmVzcyAqLwogICAgc3RydWN0IGlmcmVxIGlmcjsKICAgICh2b2lkKSBzdHJuY3B5KGlm
ci5pZnJfbmFtZSwgaWZfbmFtZSwgc2l6ZW9mKGlmci5pZnJfbmFtZSkgLSAxKTsKICAgIGlmci5p
ZnJfbmFtZVtzaXplb2YoaWZyLmlmcl9uYW1lKSAtIDFdID0gJ1wwJzsKICAgICh2b2lkKSBpb2N0
bChzb2NrLCBTSU9DR0lGSFdBRERSLCAmaWZyKTsKICAgICh2b2lkKSBjbG9zZShzb2NrKTsKICAg
ICh2b2lkKSBtZW1jcHkobWFjLCBpZnIuaWZyX2h3YWRkci5zYV9kYXRhLCA2KTsKfQoKc3RhdGlj
IGlubGluZSB2b2lkIHNldHVwX3Jpbmcoc3RydWN0IHJpbmcgKiByaW5nLCBpbnQgc29jaywgaW50
IHR5cGUpIHsKCiAgICByaW5nLT5zb2NrID0gc29jazsKICAgIHJpbmctPnR5cGUgPSB0eXBlOwog
ICAgcmluZy0+dmVyc2lvbiA9IFRQQUNLRVRfVjI7CiAgICB1MzIgZnJhbWVfc2l6ZSA9IHJvdW5k
X3VwX3RvX3Bvd18yKE1UVSArIFRQQUNLRVRfSERSTEVOICsgVFBBQ0tFVF9BTElHTk1FTlQpOwog
ICAgdTMyIGJsb2NrX3NpemUgPSBCTE9DS19TSVpFOwogICAgaWYgKGZyYW1lX3NpemUgPiBibG9j
a19zaXplKQogICAgICAgIGJsb2NrX3NpemUgPSBmcmFtZV9zaXplOwogICAgdTMyIGJsb2NrX2Nv
dW50ID0gRlJBTUVfTUVNX1NJWkUgLyBibG9ja19zaXplOwogICAgdTMyIGZyYW1lX2NvdW50ID0g
KGJsb2NrX3NpemUgLyBmcmFtZV9zaXplKSAqIGJsb2NrX2NvdW50OwogICAgdTMyIHJpbmdfc2l6
ZSA9IGZyYW1lX2NvdW50ICogc2l6ZW9mKHZvaWQgKik7CiAgICAvKiBBbGxvY2F0ZSBhbiBhcnJh
eSBvZiBwb2ludGVycyB0byB0aGUgZnJhbWVzIGluIHNoYXJlZCBidWZmZXIgKi8KICAgIHJpbmct
PmZyYW1lcyA9IG1hbGxvYyhyaW5nX3NpemUpOwogICAgYXNzZXJ0KHJpbmctPmZyYW1lcyk7Cgog
ICAgcmluZy0+dHBhY2tldF9yZXEudHBfYmxvY2tfc2l6ZSA9IGJsb2NrX3NpemU7CiAgICByaW5n
LT50cGFja2V0X3JlcS50cF9ibG9ja19uciA9IGJsb2NrX2NvdW50OwogICAgcmluZy0+dHBhY2tl
dF9yZXEudHBfZnJhbWVfc2l6ZSA9IGZyYW1lX3NpemU7CiAgICByaW5nLT50cGFja2V0X3JlcS50
cF9mcmFtZV9uciA9IGZyYW1lX2NvdW50OwoKICAgIHJpbmctPm1tYXBfbGVuID0gYmxvY2tfc2l6
ZSAqIGJsb2NrX2NvdW50OwogICAgcmluZy0+ZnJhbWVfY291bnQgPSBmcmFtZV9jb3VudDsKICAg
IHJpbmctPmZyYW1lX2xlbmd0aCA9IGZyYW1lX3NpemU7CiAgICByaW5nLT5mcmFtZV9udW0gPSAw
OwoKICAgICh2b2lkKSBzZXRzb2Nrb3B0KHNvY2ssIFNPTF9QQUNLRVQsIHR5cGUsICZyaW5nLT50
cGFja2V0X3JlcSwgc2l6ZW9mKHJpbmctPnRwYWNrZXRfcmVxKSk7Cn0KCnN0YXRpYyBpbmxpbmUg
dm9pZCBzZW5kX2Jyb2FkY2FzdF9wYWNrZXQoc3RydWN0IHJpbmcgKiB0eF9yaW5nLCBzaXplX3Qg
cGF5bG9hZF9zaXplLCB1OCBzZW5kZXJfbWFjWzZdKSB7CgogICAgc3RydWN0IHRwYWNrZXQyX2hk
ciAqIHRwX2hlYWRlciA9IHR4X3JpbmctPmZyYW1lc1t0eF9yaW5nLT5mcmFtZV9udW1dOwogICAg
LyogT25seSB0aHJlZSBsb3dlciBiaXRzIGVuY29kZSB0aGUgVFggc3RhdHVzIChhc3NlcnQgdGhl
cmUgaXMgc3BhY2UgaW4gdGhlIHJpbmcpICovCiAgICB1MzIgdHBfc3RhdHVzID0gdHBfaGVhZGVy
LT50cF9zdGF0dXMgJiAweDc7CiAgICBhc3NlcnQodHBfc3RhdHVzID09IFRQX1NUQVRVU19BVkFJ
TEFCTEUpOwogICAgdTggKiBidWYgPSAodTggKikodm9pZCAqKXRwX2hlYWRlciArIFRQQUNLRVQy
X0hEUkxFTiAtIFwKICAgICAgICBzaXplb2Yoc3RydWN0IHNvY2thZGRyX2xsKTsKCiAgICAvKiBG
aWxsIGluIHRoZSBNQUMgYWRkcmVzc2VzICovCiAgICBzdHJ1Y3QgZXRoZXJfaGVhZGVyICogZXRo
ID0gKHN0cnVjdCBldGhlcl9oZWFkZXIgKikgYnVmOwogICAgKHZvaWQpIG1lbXNldChldGgtPmV0
aGVyX2Rob3N0LCAweEZGLCA2KTsKICAgICh2b2lkKSBtZW1jcHkoZXRoLT5ldGhlcl9zaG9zdCwg
c2VuZGVyX21hYywgNik7CiAgICBldGgtPmV0aGVyX3R5cGUgPSBodG9ucyhzaXplb2Yoc3RydWN0
IGxsY19oZWFkZXIpICsgcGF5bG9hZF9zaXplKTsKICAgIC8qIEZpbGwgaW4gdGhlIExMQyBoZWFk
ZXIgKi8KICAgIHN0cnVjdCBsbGNfaGVhZGVyICogbGxjID0gKHN0cnVjdCBsbGNfaGVhZGVyICop
KGV0aCArIDEpOwogICAgbGxjLT5kc2FwID0gMDsKICAgIGxsYy0+c3NhcCA9IDA7CiAgICBsbGMt
PmNvbnRyb2wgPSAwOwogICAgLyogUG9pc29uIHRoZSBwYXlsb2FkICovCiAgICB1OCAqIHBheWxv
YWQgPSAodTggKikobGxjICsgMSk7CiAgICAodm9pZCkgbWVtc2V0KHBheWxvYWQsIDB4QUEsIHBh
eWxvYWRfc2l6ZSk7CgogICAgc2l6ZV90IHRvdGFsX2xlbiA9IHNpemVvZigqZXRoKSArIHNpemVv
ZigqbGxjKSArIHBheWxvYWRfc2l6ZTsKICAgIHRwX2hlYWRlci0+dHBfbGVuID0gdG90YWxfbGVu
OwogICAgLyogUmVsaW5xdWlzaCBjb250cm9sIG9mIHRoZSBmcmFtZSB0byB0aGUga2VybmVsICov
CiAgICB0cF9oZWFkZXItPnRwX3N0YXR1cyA9IFRQX1NUQVRVU19TRU5EX1JFUVVFU1Q7CgogICAg
LyogUGluZyB0aGUga2VybmVsIHRvIHNlbmQgdGhlIHBhY2tldCAqLwogICAgc3NpemVfdCByZXQg
PSBzZW5kKHR4X3JpbmctPnNvY2ssIE5VTEwsIDAsIE1TR19ET05UV0FJVCk7CiAgICBhc3NlcnQo
cmV0ID09IHRvdGFsX2xlbik7CiAgICB0eF9yaW5nLT5mcmFtZV9udW0gPSAodHhfcmluZy0+ZnJh
bWVfbnVtICsgMSkgJSB0eF9yaW5nLT5mcmFtZV9jb3VudDsKfQoKc3RhdGljIGlubGluZSB1MzIg
cm91bmRfdXBfdG9fcG93XzIodTMyIHgpIHsKCiAgICB1MzIgaTsKICAgIGZvciAoaSA9IDE7IGkg
PCB4OyBpIDw8PSAxKSB7CiAgICAgICAgOwogICAgfQogICAgcmV0dXJuIGk7Cn0K
--00000000000071a0de060d917344--

