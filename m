Return-Path: <netdev+bounces-241996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D764FC8B823
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B984342433
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A023224E4C6;
	Wed, 26 Nov 2025 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="TShrPWVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA4213E9C
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183619; cv=none; b=bZZmpSSZLLte3QHrH0Mtwy4YPQAXEQBZk+c95IlBf93/3yr/hBKlC0KOfxvPwH+vqBVY+3zN9Zd4orJKYIW3pOh3eMqWILkrUzpjrHce+oGqufzNuLcqoYkDZCtZLqVJXXwVWWB3dkwC8Xg1oEJDwoIFd5moesC/+fplxpdwYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183619; c=relaxed/simple;
	bh=sPq7sRfwE0qJm79HkLcoNdvhVfQwCFWiJoToSCooy3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBDwu0UgtAJYRSZ9TnbwXcHAxcw4/42JxgLcAvo/3wtJOlvkg4XtXEOOuhQ4DlcKyx6elqx/XOPgfFhOdAYRZb1aaOPdD3+tWW/WZxsbDJZ8IzbzwpShRyMU0tu7z9HK5tZTnv+/xLjxrXrq4YVCdTylWMKVrKufPqa/Pi/eyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=TShrPWVA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so68301a91.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764183617; x=1764788417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OlULarQs5GWnUSo7l9jW8hmTNLy+SK9PCGaCiguX3OU=;
        b=TShrPWVAdjqz7PR0uvB0dja08IY2lYaT+Y144paqMrCYwA/zfrytGps4+8IjKHA3ys
         EkEAJHO3XInfoU4A1UyeOiGXHJxIAPb6VVpyBoIx9KjgzOm/Z8y6p0Yi4vJE6jV5VKmw
         8xMixUT32kMSgLny1jN630I/9mFiX6Ks9HzUxtDqVfuJ23XBgJJgeaXEwcA2fNhAIEKC
         WtUkp8avRMdWlrmLFKCN6NeYdl45qVWhQ1Qisn4YSyZfvcaPRXhV7tSpJY7teBYmK9Gw
         CSN++1mntBhx+V0GhifxEhPwDz6F0AMpgx3C+mBUNdZqd6v3hGZvOHTOBYyXxGOT1/za
         Ychg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764183617; x=1764788417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlULarQs5GWnUSo7l9jW8hmTNLy+SK9PCGaCiguX3OU=;
        b=EHBytVlLNWKeoMMGPvL91IGNQCJQxPLvhQ8Zuwp1y4StTGs+WecrKmgBUdR8yoLx9c
         +TlkdAM2OnglLBTUQHvAdieP1BooWpDmdflXUQy8Ze7i5DQvEYB3dKitXPA8Hh5a6J72
         A9yYU+XSXkk5OlwQzjwjYzMV/3r8TC6jZI1km+OIY300PJT+7D9GUBFWj6AJceBH6jkd
         OLEaP3iw7OMKJeq31EMg4c3oiALmQKY/8i9Pw9GKYqhnguZkzsLck/Hkjaj8y5UoMAIL
         L4u6ReP8Ic1BPcK5pHA5+AUeN3/ZXP/H652xq60xxCYLPBiRRiE7YsmOhCJmna3kT5Dq
         GRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVn1uU8uGMfPTGQ82eQM4P5kRGKb+yW9z4pEvm2idd8Ns8MQCzoUQ6ZrwKt1L4A77eInd8Je0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0jpCYA+14W1VyveD/a8qHZXA+IJMckLFZHNBqhHgMguwuHkU
	/pA+fKtJjrC/4JRR0bZ3zmn4T7yHPmVSthF6Fihz0WedyZWO/rYsdfK6lhNHM4gC4/2lPDpOjgw
	G8GKv7vtyqi/Av/pkLfqstYj5OIP8b4Laj5hAIdv2
X-Gm-Gg: ASbGncsHd8fpcPypMYf8bfFO36IHK0aDz3iVqI3pe2SKudfRpVTgbF/31nQsk/ty91w
	zegPcMYq2wyza7VOj82+MQOozMxU0h2yIn7En+XHU+CyCMDLp2OBpZ4evr9xrwE4rgFvXbBFsz2
	KzETCSmdIyuEfiHJunbEIOtPt0INfg56HkIkVVAkLmgX+GDQUWwqv9XeDnOmvK4OlY6WZiBTNv9
	piu5WyEU4k7xE2UqJVUqgbUUskBdmu4bmT/m+C0WhLbNS5IXFAybCml7kIskhhOzNYv5+7Jli8R
	PUQ=
X-Google-Smtp-Source: AGHT+IHntpS5LvWNYPS81xYKNDop/OWCfBgtZhJM+t5lErwA4rrpgObbcL7HI9ntMGDaFKVJscWoGCj+KvH/TNSd8Nc=
X-Received: by 2002:a17:90b:1cc4:b0:341:8ad7:5f7a with SMTP id
 98e67ed59e1d1-3475ed514ccmr7211687a91.18.1764183616656; Wed, 26 Nov 2025
 11:00:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124200825.241037-1-jhs@mojatatu.com> <20251124145115.30c01882@kernel.org>
 <CAM0EoM=jDt_CeCop82aH=Fch+4M9QawX4aQdKdiUCsdFzuC2rQ@mail.gmail.com>
 <CAM0EoM=Rci1sfLFzenP9KyGhWNuLsprRZu0jS5pg2Wh35--4wg@mail.gmail.com>
 <CANn89iJiapfb3OULLv8FxQET4e-c7Kei_wyx2EYb7Wt_0qaAtw@mail.gmail.com>
 <CAM0EoMm4UZ9cM6zOTH+uT1kwyMdgEsP2BPR3C+d_-nmbXfrYyQ@mail.gmail.com> <CANn89i+_4Hj2WApgy_UBFhsDy+FEM8M1HhutrUcUHKmqbMR1-A@mail.gmail.com>
In-Reply-To: <CANn89i+_4Hj2WApgy_UBFhsDy+FEM8M1HhutrUcUHKmqbMR1-A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 26 Nov 2025 14:00:05 -0500
X-Gm-Features: AWmQ_bmzk8g10diuKGbbYhy3wn8fjV8fVE2w7yeoy4qcGzU3GHIwd6eMpnNAMWg
Message-ID: <CAM0EoMk8fMwLqQmBA1QLWxHWusEe_TA9udcR-+-1Uauxdt12Ng@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: multipart/mixed; boundary="000000000000ca452b0644840149"

--000000000000ca452b0644840149
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:20=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Nov 26, 2025 at 10:14=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
>
> > It's the multiport redirection, particularly to ingress. When it get
> > redirected to ingress it will get queued and then transitioned back.
> > xmit struct wont catch this as a recursion, so MIRRED_NEST_LIMIT will
> > not help you.
> > Example (see the first accompanying tdc test):
> > packet showing up on port0:ingress mirred redirect --> port1:egress
> > packet showing up on port1:egress mirred redirect --> port0:ingress
>
> Have you tried recording both devices ?
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index f27b583def78e4afecc7112854b93d59c2520201..711fc2e31cb0451c07a39f9c9=
4226357d5faec09
> 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -445,15 +445,17 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff=
 *skb,
>                 return retval;
>         }
>         for (i =3D 0; i < xmit->sched_mirred_nest; i++) {
> -               if (xmit->sched_mirred_dev[i] !=3D dev)
> +               if (xmit->sched_mirred_dev[i] !=3D dev &&
> +                   xmit->sched_mirred_dev[i] !=3D skb->dev)
>                         continue;
> -               pr_notice_once("tc mirred: loop on device %s\n",
> -                              netdev_name(dev));
> +               pr_notice_once("tc mirred: loop on device %s/%s\n",
> +                              netdev_name(dev), netdev_name(skb->dev));
>                 tcf_action_inc_overlimit_qstats(&m->common);
>                 return retval;
>         }
>
>         xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D dev;
> +       xmit->sched_mirred_dev[xmit->sched_mirred_nest++] =3D skb->dev;
>
>         m_mac_header_xmit =3D READ_ONCE(m->tcfm_mac_header_xmit);
>         m_eaction =3D READ_ONCE(m->tcfm_eaction);

Will try this in a bit. From outset i dont think it will help.
But here's what i tested and it works. Of course needs a lot more
scrutiny and testing but should be able to explain the idea.

cheers,
jamal

--000000000000ca452b0644840149
Content-Type: application/octet-stream; name=p-ttl
Content-Disposition: attachment; filename=p-ttl
Content-Transfer-Encoding: base64
Content-ID: <f_migdcfp60>
X-Attachment-Id: f_migdcfp60

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2lmYi5jIGIvZHJpdmVycy9uZXQvaWZiLmMKaW5kZXgg
ZDNkYzA5MTQ0NTBhLi42NTE1NWI1MzJhMWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2lmYi5j
CisrKyBiL2RyaXZlcnMvbmV0L2lmYi5jCkBAIC0xMjMsOCArMTIzLDcgQEAgc3RhdGljIHZvaWQg
aWZiX3JpX3Rhc2tsZXQoc3RydWN0IHRhc2tsZXRfc3RydWN0ICp0KQogCQl9CiAJCXJjdV9yZWFk
X3VubG9jaygpOwogCQlza2ItPnNrYl9paWYgPSB0eHAtPmRldi0+aWZpbmRleDsKLQotCQlpZiAo
IXNrYi0+ZnJvbV9pbmdyZXNzKSB7CisJCWlmICghdGNfc2tiX2NiKHNrYiktPmZyb21faW5ncmVz
cykgewogCQkJZGV2X3F1ZXVlX3htaXQoc2tiKTsKIAkJfSBlbHNlIHsKIAkJCXNrYl9wdWxsX3Jj
c3VtKHNrYiwgc2tiLT5tYWNfbGVuKTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2tidWZm
LmggYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oCmluZGV4IGZmOTAyODFkZGY5MC4uMTE4ZjBjMmEy
NDljIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvc2tidWZmLmgKQEAgLTEwMDAsNiArMTAwMCw4IEBAIHN0cnVjdCBza19idWZmIHsKIAkvKiBJ
bmRpY2F0ZXMgdGhlIGlubmVyIGhlYWRlcnMgYXJlIHZhbGlkIGluIHRoZSBza2J1ZmYuICovCiAJ
X191OAkJCWVuY2Fwc3VsYXRpb246MTsKIAlfX3U4CQkJZW5jYXBfaGRyX2NzdW06MTsKKwkvKlhY
WDogZmluZCByZWFzb25hYmxlIGlmZGVkPyBvdGhlciB0aGFuICBtaXJyZWQsIG5ldGVtIGNvdWxk
IHVzZSBpdCovCisJX191OAkJCXR0bDoyOwogCV9fdTgJCQljc3VtX3ZhbGlkOjE7CiAjaWZkZWYg
Q09ORklHX0lQVjZfTkRJU0NfTk9ERVRZUEUKIAlfX3U4CQkJbmRpc2Nfbm9kZXR5cGU6MjsKQEAg
LTEwMTYsOSArMTAxOCw2IEBAIHN0cnVjdCBza19idWZmIHsKIAlfX3U4CQkJb2ZmbG9hZF9sM19m
d2RfbWFyazoxOwogI2VuZGlmCiAJX191OAkJCXJlZGlyZWN0ZWQ6MTsKLSNpZmRlZiBDT05GSUdf
TkVUX1JFRElSRUNUCi0JX191OAkJCWZyb21faW5ncmVzczoxOwotI2VuZGlmCiAjaWZkZWYgQ09O
RklHX05FVEZJTFRFUl9TS0lQX0VHUkVTUwogCV9fdTgJCQluZl9za2lwX2VncmVzczoxOwogI2Vu
ZGlmCkBAIC01MzQ3LDM1ICs1MzQ2LDYgQEAgc3RhdGljIGlubGluZSBfX3dzdW0gbGNvX2NzdW0o
c3RydWN0IHNrX2J1ZmYgKnNrYikKIAlyZXR1cm4gY3N1bV9wYXJ0aWFsKGw0X2hkciwgY3N1bV9z
dGFydCAtIGw0X2hkciwgcGFydGlhbCk7CiB9CiAKLXN0YXRpYyBpbmxpbmUgYm9vbCBza2JfaXNf
cmVkaXJlY3RlZChjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQotewotCXJldHVybiBza2ItPnJl
ZGlyZWN0ZWQ7Ci19Ci0KLXN0YXRpYyBpbmxpbmUgdm9pZCBza2Jfc2V0X3JlZGlyZWN0ZWQoc3Ry
dWN0IHNrX2J1ZmYgKnNrYiwgYm9vbCBmcm9tX2luZ3Jlc3MpCi17Ci0Jc2tiLT5yZWRpcmVjdGVk
ID0gMTsKLSNpZmRlZiBDT05GSUdfTkVUX1JFRElSRUNUCi0Jc2tiLT5mcm9tX2luZ3Jlc3MgPSBm
cm9tX2luZ3Jlc3M7Ci0JaWYgKHNrYi0+ZnJvbV9pbmdyZXNzKQotCQlza2JfY2xlYXJfdHN0YW1w
KHNrYik7Ci0jZW5kaWYKLX0KLQotc3RhdGljIGlubGluZSB2b2lkIHNrYl9yZXNldF9yZWRpcmVj
dChzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQotewotCXNrYi0+cmVkaXJlY3RlZCA9IDA7Ci19Ci0KLXN0
YXRpYyBpbmxpbmUgdm9pZCBza2Jfc2V0X3JlZGlyZWN0ZWRfbm9jbGVhcihzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLAotCQkJCQkgICAgICBib29sIGZyb21faW5ncmVzcykKLXsKLQlza2ItPnJlZGlyZWN0
ZWQgPSAxOwotI2lmZGVmIENPTkZJR19ORVRfUkVESVJFQ1QKLQlza2ItPmZyb21faW5ncmVzcyA9
IGZyb21faW5ncmVzczsKLSNlbmRpZgotfQotCiBzdGF0aWMgaW5saW5lIGJvb2wgc2tiX2NzdW1f
aXNfc2N0cChzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogewogI2lmIElTX0VOQUJMRUQoQ09ORklHX0lQ
X1NDVFApCmRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9zY2hfZ2VuZXJpYy5oIGIvaW5jbHVkZS9u
ZXQvc2NoX2dlbmVyaWMuaAppbmRleCA5NDk2NjY5MmNjZGYuLmVkODBmN2FlNTA1OSAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9uZXQvc2NoX2dlbmVyaWMuaAorKysgYi9pbmNsdWRlL25ldC9zY2hfZ2Vu
ZXJpYy5oCkBAIC0xMDY5LDYgKzEwNjksNyBAQCBzdHJ1Y3QgdGNfc2tiX2NiIHsKIAl1OCBwb3N0
X2N0OjE7CiAJdTggcG9zdF9jdF9zbmF0OjE7CiAJdTggcG9zdF9jdF9kbmF0OjE7CisJdTggZnJv
bV9pbmdyZXNzOjE7CiB9OwogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCB0Y19za2JfY2IgKnRjX3Nr
Yl9jYihjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQpAQCAtMTA5MSw2ICsxMDkyLDM1IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCB0Y2Zfc2V0X2Ryb3BfcmVhc29uKGNvbnN0IHN0cnVjdCBza19idWZm
ICpza2IsCiAJdGNfc2tiX2NiKHNrYiktPmRyb3BfcmVhc29uID0gcmVhc29uOwogfQogCitzdGF0
aWMgaW5saW5lIGJvb2wgc2tiX2lzX3JlZGlyZWN0ZWQoY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNr
YikKK3sKKwlyZXR1cm4gc2tiLT5yZWRpcmVjdGVkOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQg
c2tiX3NldF9yZWRpcmVjdGVkKHN0cnVjdCBza19idWZmICpza2IsIGJvb2wgZnJvbV9pbmdyZXNz
KQoreworCXNrYi0+cmVkaXJlY3RlZCA9IDE7CisjaWZkZWYgQ09ORklHX05FVF9SRURJUkVDVAor
CXRjX3NrYl9jYihza2IpLT5mcm9tX2luZ3Jlc3MgPSBmcm9tX2luZ3Jlc3M7CisJaWYgKHRjX3Nr
Yl9jYihza2IpLT5mcm9tX2luZ3Jlc3MpCisJCXNrYl9jbGVhcl90c3RhbXAoc2tiKTsKKyNlbmRp
ZgorfQorCitzdGF0aWMgaW5saW5lIHZvaWQgc2tiX3Jlc2V0X3JlZGlyZWN0KHN0cnVjdCBza19i
dWZmICpza2IpCit7CisJc2tiLT5yZWRpcmVjdGVkID0gMDsKK30KKworc3RhdGljIGlubGluZSB2
b2lkIHNrYl9zZXRfcmVkaXJlY3RlZF9ub2NsZWFyKHN0cnVjdCBza19idWZmICpza2IsCisJCQkJ
CSAgICAgIGJvb2wgZnJvbV9pbmdyZXNzKQoreworCXNrYi0+cmVkaXJlY3RlZCA9IDE7CisjaWZk
ZWYgQ09ORklHX05FVF9SRURJUkVDVAorCXRjX3NrYl9jYihza2IpLT5mcm9tX2luZ3Jlc3MgPSBm
cm9tX2luZ3Jlc3M7CisjZW5kaWYKK30KKwogLyogSW5zdGVhZCBvZiBjYWxsaW5nIGtmcmVlX3Nr
YigpIHdoaWxlIHJvb3QgcWRpc2MgbG9jayBpcyBoZWxkLAogICogcXVldWUgdGhlIHNrYiBmb3Ig
ZnV0dXJlIGZyZWVpbmcgYXQgZW5kIG9mIF9fZGV2X3htaXRfc2tiKCkKICAqLwpkaWZmIC0tZ2l0
IGEvbmV0L3NjaGVkL2FjdF9taXJyZWQuYyBiL25ldC9zY2hlZC9hY3RfbWlycmVkLmMKaW5kZXgg
ZjI3YjU4M2RlZjc4Li5hMDgzYmE2M2FlOWUgMTAwNjQ0Ci0tLSBhL25ldC9zY2hlZC9hY3RfbWly
cmVkLmMKKysrIGIvbmV0L3NjaGVkL2FjdF9taXJyZWQuYwpAQCAtMzA5LDggKzMwOSwxMCBAQCBz
dGF0aWMgaW50IHRjZl9taXJyZWRfdG9fZGV2KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCB0
Y2ZfbWlycmVkICptLAogCiAJCXNrYl9zZXRfcmVkaXJlY3RlZChza2JfdG9fc2VuZCwgc2tiX3Rv
X3NlbmQtPnRjX2F0X2luZ3Jlc3MpOwogCisJCXNrYl90b19zZW5kLT50dGwrKzsKIAkJZXJyID0g
dGNmX21pcnJlZF9mb3J3YXJkKGF0X2luZ3Jlc3MsIHdhbnRfaW5ncmVzcywgc2tiX3RvX3NlbmQp
OwogCX0gZWxzZSB7CisJCXNrYl90b19zZW5kLT50dGwrKzsKIAkJZXJyID0gdGNmX21pcnJlZF9m
b3J3YXJkKGF0X2luZ3Jlc3MsIHdhbnRfaW5ncmVzcywgc2tiX3RvX3NlbmQpOwogCX0KIAlpZiAo
ZXJyKQpAQCAtNDI1LDcgKzQyNyw4IEBAIFRDX0lORElSRUNUX1NDT1BFIGludCB0Y2ZfbWlycmVk
X2FjdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAogI2Vsc2UKIAl4bWl0ID0gdGhpc19jcHVfcHRyKCZz
b2Z0bmV0X2RhdGEueG1pdCk7CiAjZW5kaWYKLQlpZiAodW5saWtlbHkoeG1pdC0+c2NoZWRfbWly
cmVkX25lc3QgPj0gTUlSUkVEX05FU1RfTElNSVQpKSB7CisKKwlpZiAoc2tiLT50dGwgPj0gTUlS
UkVEX05FU1RfTElNSVQgLSAxKSB7CiAJCW5ldF93YXJuX3JhdGVsaW1pdGVkKCJQYWNrZXQgZXhj
ZWVkZWQgbWlycmVkIHJlY3Vyc2lvbiBsaW1pdCBvbiBkZXYgJXNcbiIsCiAJCQkJICAgICBuZXRk
ZXZfbmFtZShza2ItPmRldikpOwogCQlyZXR1cm4gVENfQUNUX1NIT1Q7Cg==
--000000000000ca452b0644840149--

