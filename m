Return-Path: <netdev+bounces-256724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FY4LQZag2mJlQMAu9opvQ
	(envelope-from <netdev+bounces-256724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:39:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7BAE7375
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ABF0302F6B5
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CB3413239;
	Wed,  4 Feb 2026 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b2Jp8A8m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B52410D3E
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215756; cv=pass; b=SSerAM++QuwFbOL3J6PjVsdr299oabncThw+0GZhEx68B287AQ1mjqjmc1JLecnB0LNTRDEPBSxbzvMRLXjbzEp8qZGK5EjOUZBhzCx6lZKUvAsy3frt7rrg1FRNFeg7OBgtS4/+03j8TqZb+slnASlB77JXfnQLUM08x+5Gj6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215756; c=relaxed/simple;
	bh=Amxm02ZnNjl9UsNV/gTHFAlQv4QHgj9wltfbGW4uzdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxlCU33U0xuTEdoDU2haiUbkLEu2U/hmGvSURbPpqCL68rrB1IVsvVE2Tssfl2NOgHtZ7CZzYIQIIuspBuJrLOW87X74/OyUxtaOMmRDkTSdoT8s47XdRJWFTtC+Kqs89dDS0wW/YDZOMIhRqgQ5K5w28G+r8OHaPQcVdcv4PJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b2Jp8A8m; arc=pass smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-12339e2e2c1so510894c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 06:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770215755; x=1770820555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVCaEPJYxRwYjVFHgpLWkDgRhBbCQVX/KzfGHp6r4Zo=;
        b=TLnMww6tkt0HqPyoEaYuevvu4qeSopiVXoqRCXlptnrNAvlAyx59gpEF9jLjZIeHFm
         zwJHDZKUTZflQdY7tq6tB1z9Ye+NVc/PsH2t7rJVgfc1aGvXwQ4E2TaTnTJTZP4TDjx3
         mCJiWcdtKK0BSTm+lg1X6UGQM5A8soCzYC9K9NIJgfM2TzVPD7nGT7VPYntYyX0MDuno
         kTJt+88GcwIFaZ45KQJX53QyePRJGrl32lNC7MS8aofzF1fCsH7n8x0ot53VggbcoBvw
         6GMI7izsg7ZBrg+gTv15E0wlZw9r+bujlwIh+M4wdsvMw+prJp+1pbtm0ZrRNJWSMUDa
         /iZQ==
X-Forwarded-Encrypted: i=2; AJvYcCXSIOEe1j0gOSb5ivDplKr9Bcn/UVPK8Mfz2zx8QN1lt1kNYep00RLYPzBEE3JFO5tvtlvIqLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSZPu3JgVsSI6+WWz/IPkbbvOiBQxE9F+tIHIFhQDP5Jis0r0
	vqNNPmD7KpUCS/S52/MPKzRbAzQS5THOX4HFm8cD+di80yKHKQET2Htgst3YoA9i+1K1urFZI4k
	eeSNxegUD5PsmKYWo1Qm3qJo7sBffB0j4jh9TOR5f5XKyFoLp4o7+uXQAGa9lOrW1uHVVnDl0C4
	NP1AsmdTR4xt+mX8VfvAoxZ+1Qv5H0Y8V7KGuONlmbgawXzRXuoDdCkmNf8WNpCvsqpQg4f/0Wc
	gwGXnHztKa5Iw==
X-Gm-Gg: AZuq6aI5SxP3zme9MdaJRjRiQK4ytnrVUMVh8PUGkAnpRJVe7e18Y+zu6qFcpcNYrpO
	7ZXQp6K503Vv9QN/tkktKrFUy+vkiZB9Jqwz4jXyV5xAvG8KZxxLvU9eJ5+8w6LR+mZ7nUdxVT4
	54x4NthenMgDxVWk9xOLhpOeV9HdQE/029DHxqgnhXlZWyTJFLCahPytV7Qxx7A8pG20xd7bJm/
	3yewzkZPzuRzGAWTdyvsqiYP20fdTStdLPtQR9btgLkse5QJCgWli3XomMXP08YUoV4/t8pA3hB
	C0GQFgtSnc9C9u25CpTxCqQubRJhBPyI7TQbHyoV5M0HzsBlUkiVoXgYFGFcCzFUuZ/bSDbtaNY
	3KbLDoWg+b/i3uJKjpyDBDoLbaSettXfqlu6Cq8fRUEf4/nwRZoOXCOAabM9PclGymwjx9cWRG7
	hHEDPTXlLDx81IDTm0L9R8HMXJr7qf9bdxJoK/yMZM9A==
X-Received: by 2002:a05:7022:2491:b0:119:e569:f875 with SMTP id a92af1059eb24-126f48da932mr1369428c88.18.1770215754913;
        Wed, 04 Feb 2026 06:35:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-126f502b6e8sm449974c88.6.2026.02.04.06.35.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 06:35:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3831426aeb1so46828921fa.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 06:35:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215752; cv=none;
        d=google.com; s=arc-20240605;
        b=LbEyYWAgGNK5vPdjNGzdBCmFzydHPR5A8Ig4hxgkuihhvScbHJmSH6Bk1QUrszkLNC
         CTI4rm/eIp+aoUvqT0LO1Z9iXpiKVRl/SQ7/WSfjYapOdSnk8ttKHa5ayis2WfhRZhN3
         lHEUn7DcualCzLxKEDsTM8AknxWRlvBpS3qDZ/OM1sd3hMAa/2dpMGJzwjNQNsfHf46o
         LJBJBgnLFMn17kxnbz3koHG7bveP30CTbWiz/07tVfnm91BlCvN41TKUs1C8LJw3w+14
         7dvxrg8EndmwYc/pBdrbSbXuOZpoTh9qVLPwzY8o6CNpve5Y6+LTWn7O9wpoKNZ4uvhI
         IODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QVCaEPJYxRwYjVFHgpLWkDgRhBbCQVX/KzfGHp6r4Zo=;
        fh=2WFd47F7cjguXGUZqQEcKyY4wVtsUlkpn1Rs/GdGEWk=;
        b=LT8e9ZNSmk0QI3BaC45gFrU38g1rBWTThXUznJjTR1XG58lEY4jgwF8024YmlMPY0/
         J+QLoqlNByoxBDTDmjsORNozitH6+Fhw7jDIvep09lcu2QF0nFVuyP/XkKFxXLCOd+Dd
         ilr/AEsKNVaqCza7Yyt1N0SMEhSYHkCM9aNAaYcD/Jya3F50ihEJq+a2E0qj9JgOnhrL
         JyriL5iJk19t9pPXA+hTiRgSK3d3tf5yE4OHgK4iQJ2rJxEfWv97bIvOO/G3Pk1JxQEV
         XO/H+OjG5RCHOUu+OGodmQmlP9sxfllm78DkIyq4MSYvx5RrbFW8eog1/U3Mr+u+mkwl
         lDVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770215752; x=1770820552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVCaEPJYxRwYjVFHgpLWkDgRhBbCQVX/KzfGHp6r4Zo=;
        b=b2Jp8A8mDvnNQjntqv6uUlWiPCtrciOSTEQjgHNo+xOBuhslkVW3jmszN9s3ouhoT8
         i3tK8n5FhmPSBvzC+/YVvm3ENWg+pQt/Hk4mqbTF5BN4xCdDvctplAD3iuCqFPVrDFa5
         JW86Zcu7OUVFSAndtRO0Ygk+axHBLKd7G+tCE=
X-Forwarded-Encrypted: i=1; AJvYcCXGHw6/EbnD8C+01Rbm94Y9ERsmMOTFWeMJCk8qMZxJWw/5ebHMOkh0xtwunz4E7uvCxObfM7c=@vger.kernel.org
X-Received: by 2002:a2e:a541:0:b0:386:9325:228b with SMTP id 38308e7fff4ca-38693252d07mr10245771fa.5.1770215751910;
        Wed, 04 Feb 2026 06:35:51 -0800 (PST)
X-Received: by 2002:a2e:a541:0:b0:386:9325:228b with SMTP id
 38308e7fff4ca-38693252d07mr10245651fa.5.1770215751475; Wed, 04 Feb 2026
 06:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203163406.2636463-1-arnd@kernel.org>
In-Reply-To: <20260203163406.2636463-1-arnd@kernel.org>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Wed, 4 Feb 2026 14:35:38 +0000
X-Gm-Features: AZwV_Qg41O2rRKZlfo4K052mHOgqNH9m_DTbwtaGbYuTAdAW_oY1maGK7XkKKJ8
Message-ID: <CAOuBmuY4qOYUvbGhNbrDiexRmFy1QKHe1vxL24so8SZSM8oCmQ@mail.gmail.com>
Subject: Re: [PATCH] vmw_vsock: bypass false-positive Wnonnull warning with gcc-16
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Simon Horman <horms@kernel.org>, 
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000187726064a00797d"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256724-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan-bt.tan@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,arndb.de:email,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: 2E7BAE7375
X-Rspamd-Action: no action

--000000000000187726064a00797d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 4:34=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The gcc-16.0.1 snapshot produces a false-positive warning that turns
> into a build failure with CONFIG_WERROR:
>
> In file included from arch/x86/include/asm/string.h:6,
>                  from net/vmw_vsock/vmci_transport.c:10:
> In function 'vmci_transport_packet_init',
>     inlined from '__vmci_transport_send_control_pkt.constprop' at net/vmw=
_vsock/vmci_transport.c:198:2:
> arch/x86/include/asm/string_32.h:150:25: error: argument 2 null where non=
-null expected because argument 3 is nonzero [-Werror=3Dnonnull]
>   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcp=
y'
>   164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>       |                 ^~~~~~
> arch/x86/include/asm/string_32.h:150:25: note: in a call to built-in func=
tion '__builtin_memcpy'
> net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcp=
y'
>   164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>       |                 ^~~~~~
>
> This seems relatively harmless, and it so far the only instance of this
> warning I have found. The __vmci_transport_send_control_pkt function
> is called either with wait=3DNULL or with one of the type values that
> pass 'wait' into memcpy() here, but not from the same caller.
>
> Replacing the memcpy with a struct assignment is otherwise the same
> but avoids the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/vmw_vsock/vmci_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 00f6bbdb035a..a64522be1bad 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -161,7 +161,7 @@ vmci_transport_packet_init(struct vmci_transport_pack=
et *pkt,
>
>         case VMCI_TRANSPORT_PACKET_TYPE_WAITING_READ:
>         case VMCI_TRANSPORT_PACKET_TYPE_WAITING_WRITE:
> -               memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
> +               pkt->u.wait =3D *wait;
>                 break;
>
>         case VMCI_TRANSPORT_PACKET_TYPE_REQUEST2:
> --
> 2.39.5
>

Reviewed-by: Bryan Tan <bryan-bt.tan@broadcom.com>

--000000000000187726064a00797d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
kKXUf8BmgVwrm4J21BIjpK/E9/meSALtIG7FIMpiIKpgHf1MRTzmYywQIWohaXxPRAEIYZK2DSMY
n+fDChhou4ePAtzo6/x8PTSWPrJbH05U1DQt9FRG7+xcvkNqnjJq+XZK0kiDDFD8BzIKO/cq3ziS
50EhbzFKXPpa46ztpJqQ+UJTJod2dB7SexAYJlBkjKlGc+niNQIDAQABo4IB2jCCAdYwDgYDVR0P
AQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEGA1UdHwQ6MDgw
NqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzLmNybDAk
BgNVHREEHTAbgRlicnlhbi1idC50YW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQWxgja/oUqPdrOSir6
U+YDJVND/DANBgkqhkiG9w0BAQsFAAOCAgEAIL+CGrIYdRkQ80Psq9FtFG65/EZQH8dFSXv3AJTk
220m3Q98q4NHh+AkBRw/pvzVQMJlRKEBKgM1qYw5FYYoC3IRpeqQ9NqnJHsEAHX2p7Hfkt3l8zd7
rT9DuQ4Tws1Fjxo4L7OcRz8NDD9f0Y+LHADvcMUHoex2PldpXkGuWd4K1eMjga8xPOrKKYYdvWYw
cX/rc+AYfo3B0OnjSWXjdsufMPVDDK23uGYfti1djyVhYG7hOCKjW3fg9QdDcVjVa4q7spoCPGnQ
HGghAH5+ZauOJU1r26oGjwR/73xvsig9pX887/zvEM5WdbTXK82mciLRR4iQB0UlV+8UxxpJzfGd
j/6onem1o3e1fTH0owcQEn59i7Ygo5cWJm0qnT7zPTS6pgkXJ4xmskj6Dcqi/hRkMlxovq3K05uN
+lgAFg6F7ugpiGTUcxngHsGMRlj8cXIhg8KZO0gBU5KthBSvioQgN2JpAyE5gUV7stnVCu8l+SAr
Oo+OqcCeAc14zE+TlRnoQVn/xF+q0zAyONDNmQO4uyl0EyLpTIYLK7wFxC6IDrz2FsEzlioH2cBJ
lUyNMZuhR7c1KUj3dr4qBG1506iDiJ5qqn2rBKJAvk0ph2Irlh+82seX1iL/wX+M+Wwkzoo34GGq
6CGv4ffBr8W+eQ2/QT4X10tgfAgSZ+Sag3gxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgx+bIvtS2ArBR9RakkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
IDKktijIXGx+3YZx1cZ1Tj6NawZx7l1sVCcse3ZHMZY+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIwNDE0MzU1MlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKMbrDobX4LKKYD/Kxqd7v48QJADsf8voMC6
dTb0m77bEoGRZ4HLjWnmeZBeCMz9ikrEFxa9QlR3B/LAnMWmd6gMizsWHqUbla3g4vijl6X67SbQ
r06OzQbo443viZoUZI/KzU1HgCR4WF6HTNILQfyzkrgQ9cFFYa140MoiYkwq1h33WAKmhrp499iZ
zDYSDar7IHto3DCCH5HatJOjZApklzrGe2Cx79lytV5UPqJJ5gTewO92c/e0Dzey6S4kKfDh5il/
qs1OqoQurQzJ3swRate5GrkMa0ojDCUXdxzsuqgsnd2QmJOWGwU8RZ+4ntG8jaNRD7cBi2AmRz5S
Vvc=
--000000000000187726064a00797d--

