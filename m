Return-Path: <netdev+bounces-167663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3780BA3B847
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE88717BE8B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C598E1E833F;
	Wed, 19 Feb 2025 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOewRHQk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4B1D54E9
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956326; cv=none; b=HLnWnwlcRdh2c5GeWSIPTYYV82OsezvGznxGk6m3zoKmRHv1ZlhkxYBngPO3FE4A+aOofhycOsP7pGLxNyEzkdvdZgG70mjdW/2Mp9myVG4Qh7eAPu8lfQLxFqEOGLIhiTdfFC+U5SB8JoJFRWfF+8N9/YMzOcCG70Xl94W/KRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956326; c=relaxed/simple;
	bh=pbTzYBJE4AFKgFapl1MfKOGC5SaYbVMGlhMNj7e1KL0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=e+utUmUSx0qGhTYco+VrskuHtT8naWiSij08dY0deuD5f0TVr7UTkQiBDA+r+vbKa0Xqw0jpxs4pt7nzq65DgUGDxV+keaIsipRemuLFWU8iOaMLLGMg04CRWBUcvxD1ZGH7dRk+pVF6AiP/K5WECvVCoSxKCi3A0wzJJseRh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOewRHQk; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e5ddd781316so2635784276.2
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 01:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739956324; x=1740561124; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gKBYeQZ/zMZ7HaHeU7WC4uQk1qKlfAH2p72Rn0YlF4c=;
        b=lOewRHQkEEOrJTXMbk2maR1OVFC4mUwSDtPmLwJ7+47AA62i87bKuBRuh+mHRx1aAg
         g9bkVgYLIK+mp8NUo8itcyOxyRy2s5MwNInbZejfxd8PRNsJjHlJPouAveh+QXHjJrVl
         cDziFJQieKVzAZYrdctprrt/7hOq0BCBzV/By/0F6rKLbFyKAamwwxvx9W7XsDDj5/MU
         h8R9mYgaoMQfYqLQxRMyxJQOaOp04adBPXkoN+cZB/qo7GCogCeJqH6LMQSMP89LpUOl
         OLMryGtigdzRjKDGopYjVjXcmqgVQ6OtwpsN5GPq/JwoPNmYXLkTZEVxb3/dodslsG4L
         JYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956324; x=1740561124;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKBYeQZ/zMZ7HaHeU7WC4uQk1qKlfAH2p72Rn0YlF4c=;
        b=HmCAsKhTdq0d5l1qRJzIzITHk9s9SQzu2zcDsHaZtEZId3/UffO6t/anMSlLBCaAA6
         gwR9cQzJLYPcRHUh6tU8OpY5A/baDreV2rnKDo8re88ZVLzm4wH17eP9TjLjv2UME/K2
         Ba7vTWzle7xjS5/xIzsMC3fs7EC93qDKEtuncV/rrIZjq3ym8afDLfhejQ4t8YODb04E
         Af4cM2/XRqLyHaWe7OpBH1KgGCyGS6IDkfCJW4C5wuKr9XAVXZK46Xzof3ySIwW1tNTd
         zOJtjSsI4/wIkTi7PlCsrH7k2vNzBFZMFLf8jzQChHUeYv6NFbUji0tK0h02FAhH51pa
         AUKQ==
X-Gm-Message-State: AOJu0YwZVr3YgEcthKyoyebOcQeE6DVQH/PUuqTaSBL/TsrwS4eOnESW
	Ejf/J+W095XPcs51O3K0u4dkrOcK+0yJFn/mv64u3t1I5/k2NPOlC3bcn+KO36LPfC6/aqNa+5t
	U+Rex9Rrusner/V6p7LvsZ/dorYyeHwRon+Hk6g==
X-Gm-Gg: ASbGncsUyI6aquQaZ/QtabjLEbbSBky97NMyLRACgvoRRS9rVa7BpVRI2KSH8QjuF1i
	WihIbNNpOAFfE4pDdw67jJU3ClOStlxfVcqyvx05MKm2/Nbf1SipI1wWg76IR28BkeSGg/3+L
X-Google-Smtp-Source: AGHT+IFfoRXIqkZDYNpdi+pNPPxepZz3aoaPb/crOxR0SvimF+9f2esQpcBVR8GCB8xcl3/PcekzBeEODA3E/cFE4OA=
X-Received: by 2002:a05:6902:27c7:b0:e5d:bf59:3343 with SMTP id
 3f1490d57ef6-e5dc92fd40emr13296135276.38.1739956323719; Wed, 19 Feb 2025
 01:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ziao Li <leeziao0331@gmail.com>
Date: Wed, 19 Feb 2025 17:11:51 +0800
X-Gm-Features: AWEUYZnt_53tRhWGWGa5uAWXHsdCaxLvZFFX6NPXMXQkTXRfDzOwtqEkbGoGBMg
Message-ID: <CA+uiC5YJC0_PLGGpw_Say15-C4zd0bgCu+7VWaB1GYFd7j0xdg@mail.gmail.com>
Subject: [PATCH iproute2] NULL Pointer Dereference vulnerability and patch
To: netdev@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000099dcf2062e7b26bf"

--00000000000099dcf2062e7b26bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

NULL Pointer Dereference vulnerability in iproute2.
The vulnerability happens in load_ugly_table(), misc/nstat.c, in the
latest version of iproute2 (41710ace5e8fadff354f3dba67bf27ed3a3c5ae7)
How the vulnerability happens:
1. db is set to NULL at struct nstat_ent *db =3D NULL;
2. n is set to NULL at n =3D db;
3. NULL dereference of variable n happens at sscanf(p+1, "%llu", &n->val) !=
=3D 1
static void load_ugly_table(FILE *fp)
{
        char *buf =3D NULL;
        size_t buflen =3D 0;
        ssize_t nread;
        struct nstat_ent *db =3D NULL;
        struct nstat_ent *n;

        while ((nread =3D getline(&buf, &buflen, fp)) !=3D -1) {
                char idbuf[4096];
                int  off;
                char *p;
                int count1, count2, skip =3D 0;

                p =3D strchr(buf, ':');
                if (!p) {
                        fprintf(stderr, "%s:%d: error parsing history file\=
n",
                                __FILE__, __LINE__);
                        exit(-2);
                }
                count1 =3D count_spaces(buf);
                *p =3D 0;
                idbuf[0] =3D 0;
                strncat(idbuf, buf, sizeof(idbuf) - 1);
                off =3D p - buf;
                p +=3D 2;

                while (*p) {
                    ......
                }
                n =3D db;
                nread =3D getline(&buf, &buflen, fp);
                if (nread =3D=3D -1) {
                        fprintf(stderr, "%s:%d: error parsing history file\=
n",
                                __FILE__, __LINE__);
                        exit(-2);
                }
                count2 =3D count_spaces(buf);
                if (count2 > count1)
                        skip =3D count2 - count1;
                do {
                        p =3D strrchr(buf, ' ');
                        if (!p) {
                                fprintf(stderr, "%s:%d: error parsing
history file\n",
                                        __FILE__, __LINE__);
                                exit(-2);
                        }
                        *p =3D 0;
                        if (sscanf(p+1, "%llu", &n->val) !=3D 1) {
                                fprintf(stderr, "%s:%d: error parsing
history file\n",
                                        __FILE__, __LINE__);
                                exit(-2);
                        }
                        /* Trick to skip "dummy" trailing ICMP MIB in 2.4 *=
/
                        if (skip)
                                skip--;
                        else
                                n =3D n->next;
                } while (p > buf + off + 2);
        }
        free(buf);
        ......
}

---
Steps to reproduce:
1. Put attachment files file at misc/poc.c and misc/crash.txt
2. Compile poc.c file with:
gcc -Wall -Wstrict-prototypes  -Wmissing-prototypes
-Wmissing-declarations -Wold-style-definition -Wformat=3D2 -g -O0 -pipe
-I../include -I../include/uapi -DRESOLVE_HOSTNAMES
-DLIBDIR=3D\"/usr/lib\" -DCONF_USR_DIR=3D\"/usr/share/iproute2\"
-DCONF_ETC_DIR=3D\"/etc/iproute2\" -DNETNS_RUN_DIR=3D\"/var/run/netns\"
-DNETNS_ETC_DIR=3D\"/etc/netns\" -DARPDDIR=3D\"/var/lib/arpd\"
-DCONF_COLOR=3DCOLOR_OPT_NEVER -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -DHAVE_SETNS
-DHAVE_HANDLE_AT -DHAVE_SELINUX  -DHAVE_RPC -I/usr/include/tirpc
-DHAVE_ELF  -DNEED_STRLCPY -DHAVE_LIBCAP  -DHAVE_SETNS
-DHAVE_HANDLE_AT -DHAVE_SELINUX  -DHAVE_RPC -I/usr/include/tirpc
-DHAVE_ELF  -DNEED_STRLCPY -DHAVE_LIBCAP -o poc poc.c -lselinux
-ltirpc -lelf -lcap ../lib/libutil.a ../lib/libnetlink.a -lselinux
-ltirpc -lelf -lcap -lm
3. Run the poc by
$ ./poc crash.txt
zsh: segmentation fault (core dumped)  ./poc crash.txt
---
Patch for the vulnerability:

From 2f462d5adf071827285291d2ce13119e220681fd Mon Sep 17 00:00:00 2001
From: lza <leeziao0331@gmail.com>
Date: Wed, 19 Feb 2025 08:38:48 +0000
Subject: [PATCH] Fix Null Dereference when no entries are specified

---
 misc/nstat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/misc/nstat.c b/misc/nstat.c
index fce3e9c1..b2e19bde 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -218,6 +218,10 @@ static void load_ugly_table(FILE *fp)
            p =3D next;
        }
        n =3D db;
+       if (n =3D=3D NULL) {
+           fprintf(stderr, "Error: Invalid input =E2=80=93 line has ':' bu=
t
no entries. Add values after ':'.\n");
+           exit(-2);
+       }
        nread =3D getline(&buf, &buflen, fp);
        if (nread =3D=3D -1) {
            fprintf(stderr, "%s:%d: error parsing history file\n",
--=20
2.34.1

--00000000000099dcf2062e7b26bf
Content-Type: text/plain; charset="US-ASCII"; name="crash.txt"
Content-Disposition: attachment; filename="crash.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m7bp1no41>
X-Attachment-Id: f_m7bp1no41

dGVzdDoKIDEyMw==
--00000000000099dcf2062e7b26bf
Content-Type: application/octet-stream; name="poc.c"
Content-Disposition: attachment; filename="poc.c"
Content-Transfer-Encoding: base64
Content-ID: <f_m7bp1nnx0>
X-Attachment-Id: f_m7bp1nnx0

LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgKi8KLyoKICogbnN0
YXQuYwloYW5keSB1dGlsaXR5IHRvIHJlYWQgY291bnRlcnMgL3Byb2MvbmV0L25ldHN0YXQgYW5k
IHNubXAKICoKICogQXV0aG9yczoJQWxleGV5IEt1em5ldHNvdiwgPGt1em5ldEBtczIuaW5yLmFj
LnJ1PgogKi8KCiAjaW5jbHVkZSA8c3RkaW8uaD4KICNpbmNsdWRlIDxzdGRsaWIuaD4KICNpbmNs
dWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxmY250bC5oPgogI2luY2x1ZGUgPHN0cmluZy5oPgog
I2luY2x1ZGUgPGVycm5vLmg+CiAjaW5jbHVkZSA8dGltZS5oPgogI2luY2x1ZGUgPHN5cy90aW1l
Lmg+CiAjaW5jbHVkZSA8Zm5tYXRjaC5oPgogI2luY2x1ZGUgPHN5cy9maWxlLmg+CiAjaW5jbHVk
ZSA8c3lzL3NvY2tldC5oPgogI2luY2x1ZGUgPHN5cy91bi5oPgogI2luY2x1ZGUgPHBvbGwuaD4K
ICNpbmNsdWRlIDxzeXMvd2FpdC5oPgogI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiAjaW5jbHVkZSA8
c2lnbmFsLmg+CiAjaW5jbHVkZSA8bWF0aC5oPgogI2luY2x1ZGUgPGdldG9wdC5oPgogCiAjaW5j
bHVkZSA8anNvbl93cml0ZXIuaD4KICNpbmNsdWRlICJ2ZXJzaW9uLmgiCiAjaW5jbHVkZSAidXRp
bHMuaCIKIAogaW50IGR1bXBfemVyb3M7CiBpbnQgcmVzZXRfaGlzdG9yeTsKIGludCBpZ25vcmVf
aGlzdG9yeTsKIGludCBub19vdXRwdXQ7CiBpbnQganNvbl9vdXRwdXQ7CiBpbnQgbm9fdXBkYXRl
OwogaW50IHNjYW5faW50ZXJ2YWw7CiBpbnQgdGltZV9jb25zdGFudDsKIGRvdWJsZSBXOwogY2hh
ciAqKnBhdHRlcm5zOwogaW50IG5wYXR0ZXJuczsKIAogY2hhciBpbmZvX3NvdXJjZVsxMjhdOwog
aW50IHNvdXJjZV9taXNtYXRjaDsKIAogc3RhdGljIEZJTEUgKm5ldF9uZXRzdGF0X29wZW4odm9p
ZCkKIHsKCSByZXR1cm4gZ2VuZXJpY19wcm9jX29wZW4oIlBST0NfTkVUX05FVFNUQVQiLCAibmV0
L25ldHN0YXQiKTsKIH0KIAogc3RhdGljIEZJTEUgKm5ldF9zbm1wX29wZW4odm9pZCkKIHsKCSBy
ZXR1cm4gZ2VuZXJpY19wcm9jX29wZW4oIlBST0NfTkVUX1NOTVAiLCAibmV0L3NubXAiKTsKIH0K
IAogc3RhdGljIEZJTEUgKm5ldF9zbm1wNl9vcGVuKHZvaWQpCiB7CgkgcmV0dXJuIGdlbmVyaWNf
cHJvY19vcGVuKCJQUk9DX05FVF9TTk1QNiIsICJuZXQvc25tcDYiKTsKIH0KIAogc3RhdGljIEZJ
TEUgKm5ldF9zY3RwX3NubXBfb3Blbih2b2lkKQogewoJIHJldHVybiBnZW5lcmljX3Byb2Nfb3Bl
bigiUFJPQ19ORVRfU0NUUF9TTk1QIiwgIm5ldC9zY3RwL3NubXAiKTsKIH0KIAogc3RydWN0IG5z
dGF0X2VudCB7Cgkgc3RydWN0IG5zdGF0X2VudCAqbmV4dDsKCSBjaGFyCQkgKmlkOwoJIHVuc2ln
bmVkIGxvbmcgbG9uZyB2YWw7CgkgZG91YmxlCQkgICByYXRlOwogfTsKIAogc3RydWN0IG5zdGF0
X2VudCAqa2Vybl9kYjsKIHN0cnVjdCBuc3RhdF9lbnQgKmhpc3RfZGI7CiAKIHN0YXRpYyBjb25z
dCBjaGFyICp1c2VsZXNzX251bWJlcnNbXSA9IHsKCSAiSXBGb3J3YXJkaW5nIiwgIklwRGVmYXVs
dFRUTCIsCgkgIlRjcFJ0b0FsZ29yaXRobSIsICJUY3BSdG9NaW4iLCAiVGNwUnRvTWF4IiwKCSAi
VGNwTWF4Q29ubiIsICJUY3BDdXJyRXN0YWIiCiB9OwogCiBzdGF0aWMgaW50IHVzZWxlc3NfbnVt
YmVyKGNvbnN0IGNoYXIgKmlkKQogewoJIGludCBpOwogCgkgZm9yIChpID0gMDsgaSA8IEFSUkFZ
X1NJWkUodXNlbGVzc19udW1iZXJzKTsgaSsrKQoJCSBpZiAoc3RyY21wKGlkLCB1c2VsZXNzX251
bWJlcnNbaV0pID09IDApCgkJCSByZXR1cm4gMTsKCSByZXR1cm4gMDsKIH0KIAogc3RhdGljIGlu
dCBtYXRjaChjb25zdCBjaGFyICppZCkKIHsKCSBpbnQgaTsKIAoJIGlmIChucGF0dGVybnMgPT0g
MCkKCQkgcmV0dXJuIDE7CiAKCSBmb3IgKGkgPSAwOyBpIDwgbnBhdHRlcm5zOyBpKyspIHsKCQkg
aWYgKCFmbm1hdGNoKHBhdHRlcm5zW2ldLCBpZCwgRk5NX0NBU0VGT0xEKSkKCQkJIHJldHVybiAx
OwoJIH0KCSByZXR1cm4gMDsKIH0KIAogc3RhdGljIHZvaWQgbG9hZF9nb29kX3RhYmxlKEZJTEUg
KmZwKQogewoJIGNoYXIgYnVmWzQwOTZdOwoJIHN0cnVjdCBuc3RhdF9lbnQgKmRiID0gTlVMTDsK
CSBzdHJ1Y3QgbnN0YXRfZW50ICpuOwogCgkgd2hpbGUgKGZnZXRzKGJ1Ziwgc2l6ZW9mKGJ1Ziks
IGZwKSAhPSBOVUxMKSB7CgkJIGludCBucjsKCQkgdW5zaWduZWQgbG9uZyBsb25nIHZhbDsKCQkg
ZG91YmxlIHJhdGU7CgkJIGNoYXIgaWRidWZbc2l6ZW9mKGJ1ZildOwogCgkJIGlmIChidWZbMF0g
PT0gJyMnKSB7CgkJCSBidWZbc3RybGVuKGJ1ZiktMV0gPSAwOwoJCQkgaWYgKGluZm9fc291cmNl
WzBdICYmIHN0cmNtcChpbmZvX3NvdXJjZSwgYnVmKzEpKQoJCQkJIHNvdXJjZV9taXNtYXRjaCA9
IDE7CgkJCSBzdHJsY3B5KGluZm9fc291cmNlLCBidWYgKyAxLCBzaXplb2YoaW5mb19zb3VyY2Up
KTsKCQkJIGNvbnRpbnVlOwoJCSB9CgkJIC8qIGlkYnVmIGlzIGFzIGJpZyBhcyBidWYsIHNvIHRo
aXMgaXMgc2FmZSAqLwoJCSBuciA9IHNzY2FuZihidWYsICIlcyVsbHUlbGciLCBpZGJ1ZiwgJnZh
bCwgJnJhdGUpOwoJCSBpZiAobnIgPCAyKSB7CgkJCSBmcHJpbnRmKHN0ZGVyciwgIiVzOiVkOiBl
cnJvciBwYXJzaW5nIGhpc3RvcnkgZmlsZVxuIiwKCQkJCSBfX0ZJTEVfXywgX19MSU5FX18pOwoJ
CQkgZXhpdCgtMik7CgkJIH0KCQkgaWYgKG5yIDwgMykKCQkJIHJhdGUgPSAwOwoJCSBpZiAodXNl
bGVzc19udW1iZXIoaWRidWYpKQoJCQkgY29udGludWU7CgkJIGlmICgobiA9IG1hbGxvYyhzaXpl
b2YoKm4pKSkgPT0gTlVMTCkgewoJCQkgcGVycm9yKCJuc3RhdDogbWFsbG9jIik7CgkJCSBleGl0
KC0xKTsKCQkgfQoJCSBuLT5pZCA9IHN0cmR1cChpZGJ1Zik7CgkJIG4tPnZhbCA9IHZhbDsKCQkg
bi0+cmF0ZSA9IHJhdGU7CgkJIG4tPm5leHQgPSBkYjsKCQkgZGIgPSBuOwoJIH0KIAoJIHdoaWxl
IChkYikgewoJCSBuID0gZGI7CgkJIGRiID0gZGItPm5leHQ7CgkJIG4tPm5leHQgPSBrZXJuX2Ri
OwoJCSBrZXJuX2RiID0gbjsKCSB9CiB9CiAKIHN0YXRpYyBpbnQgY291bnRfc3BhY2VzKGNvbnN0
IGNoYXIgKmxpbmUpCiB7CgkgaW50IGNvdW50ID0gMDsKCSBjaGFyIGM7CiAKCSB3aGlsZSAoKGMg
PSAqbGluZSsrKSAhPSAwKQoJCSBjb3VudCArPSBjID09ICcgJyB8fCBjID09ICdcbic7CgkgcmV0
dXJuIGNvdW50OwogfQogCiBzdGF0aWMgdm9pZCBsb2FkX3VnbHlfdGFibGUoRklMRSAqZnApCiB7
CgkgY2hhciAqYnVmID0gTlVMTDsKCSBzaXplX3QgYnVmbGVuID0gMDsKCSBzc2l6ZV90IG5yZWFk
OwoJIHN0cnVjdCBuc3RhdF9lbnQgKmRiID0gTlVMTDsKCSBzdHJ1Y3QgbnN0YXRfZW50ICpuOwog
Cgkgd2hpbGUgKChucmVhZCA9IGdldGxpbmUoJmJ1ZiwgJmJ1ZmxlbiwgZnApKSAhPSAtMSkgewoJ
CSBjaGFyIGlkYnVmWzQwOTZdOwoJCSBpbnQgIG9mZjsKCQkgY2hhciAqcDsKCQkgaW50IGNvdW50
MSwgY291bnQyLCBza2lwID0gMDsKIAoJCSBwID0gc3RyY2hyKGJ1ZiwgJzonKTsKCQkgaWYgKCFw
KSB7CgkJCSBmcHJpbnRmKHN0ZGVyciwgIiVzOiVkOiBlcnJvciBwYXJzaW5nIGhpc3RvcnkgZmls
ZVxuIiwKCQkJCSBfX0ZJTEVfXywgX19MSU5FX18pOwoJCQkgZXhpdCgtMik7CgkJIH0KCQkgY291
bnQxID0gY291bnRfc3BhY2VzKGJ1Zik7CgkJICpwID0gMDsKCQkgaWRidWZbMF0gPSAwOwoJCSBz
dHJuY2F0KGlkYnVmLCBidWYsIHNpemVvZihpZGJ1ZikgLSAxKTsKCQkgb2ZmID0gcCAtIGJ1ZjsK
CQkgcCArPSAyOwogCgkJIHdoaWxlICgqcCkgewoJCQkgY2hhciAqbmV4dDsKIAoJCQkgaWYgKChu
ZXh0ID0gc3RyY2hyKHAsICcgJykpICE9IE5VTEwpCgkJCQkgKm5leHQrKyA9IDA7CgkJCSBlbHNl
IGlmICgobmV4dCA9IHN0cmNocihwLCAnXG4nKSkgIT0gTlVMTCkKCQkJCSAqbmV4dCsrID0gMDsK
CQkJIGlmIChvZmYgPCBzaXplb2YoaWRidWYpKSB7CgkJCQkgaWRidWZbb2ZmXSA9IDA7CgkJCQkg
c3RybmNhdChpZGJ1ZiwgcCwgc2l6ZW9mKGlkYnVmKSAtIG9mZiAtIDEpOwoJCQkgfQoJCQkgbiA9
IG1hbGxvYyhzaXplb2YoKm4pKTsKCQkJIGlmICghbikgewoJCQkJIHBlcnJvcigibnN0YXQ6IG1h
bGxvYyIpOwoJCQkJIGV4aXQoLTEpOwoJCQkgfQoJCQkgbi0+aWQgPSBzdHJkdXAoaWRidWYpOwoJ
CQkgaWYgKG4tPmlkID09IE5VTEwpIHsKCQkJCSBwZXJyb3IoIm5zdGF0OiBzdHJkdXAiKTsKCQkJ
CSBleGl0KC0xKTsKCQkJIH0KCQkJIG4tPnJhdGUgPSAwOwoJCQkgbi0+bmV4dCA9IGRiOwoJCQkg
ZGIgPSBuOwoJCQkgaWYgKG5leHQgPT0gTlVMTCkKCQkJCSBicmVhazsKCQkJIHAgPSBuZXh0OwoJ
CSB9CgkJIG4gPSBkYjsKCQkgbnJlYWQgPSBnZXRsaW5lKCZidWYsICZidWZsZW4sIGZwKTsKCQkg
aWYgKG5yZWFkID09IC0xKSB7CgkJCSBmcHJpbnRmKHN0ZGVyciwgIiVzOiVkOiBlcnJvciBwYXJz
aW5nIGhpc3RvcnkgZmlsZVxuIiwKCQkJCSBfX0ZJTEVfXywgX19MSU5FX18pOwoJCQkgZXhpdCgt
Mik7CgkJIH0KCQkgY291bnQyID0gY291bnRfc3BhY2VzKGJ1Zik7CgkJIGlmIChjb3VudDIgPiBj
b3VudDEpCgkJCSBza2lwID0gY291bnQyIC0gY291bnQxOwoJCSBkbyB7CgkJCSBwID0gc3RycmNo
cihidWYsICcgJyk7CgkJCSBpZiAoIXApIHsKCQkJCSBmcHJpbnRmKHN0ZGVyciwgIiVzOiVkOiBl
cnJvciBwYXJzaW5nIGhpc3RvcnkgZmlsZVxuIiwKCQkJCQkgX19GSUxFX18sIF9fTElORV9fKTsK
CQkJCSBleGl0KC0yKTsKCQkJIH0KCQkJICpwID0gMDsKCQkJIGlmIChzc2NhbmYocCsxLCAiJWxs
dSIsICZuLT52YWwpICE9IDEpIHsKCQkJCSBmcHJpbnRmKHN0ZGVyciwgIiVzOiVkOiBlcnJvciBw
YXJzaW5nIGhpc3RvcnkgZmlsZVxuIiwKCQkJCQkgX19GSUxFX18sIF9fTElORV9fKTsKCQkJCSBl
eGl0KC0yKTsKCQkJIH0KCQkJIC8qIFRyaWNrIHRvIHNraXAgImR1bW15IiB0cmFpbGluZyBJQ01Q
IE1JQiBpbiAyLjQgKi8KCQkJIGlmIChza2lwKQoJCQkJIHNraXAtLTsKCQkJIGVsc2UKCQkJCSBu
ID0gbi0+bmV4dDsKCQkgfSB3aGlsZSAocCA+IGJ1ZiArIG9mZiArIDIpOwoJIH0KCSBmcmVlKGJ1
Zik7CiAKCSB3aGlsZSAoZGIpIHsKCQkgbiA9IGRiOwoJCSBkYiA9IGRiLT5uZXh0OwoJCSBpZiAo
dXNlbGVzc19udW1iZXIobi0+aWQpKSB7CgkJCSBmcmVlKG4tPmlkKTsKCQkJIGZyZWUobik7CgkJ
IH0gZWxzZSB7CgkJCSBuLT5uZXh0ID0ga2Vybl9kYjsKCQkJIGtlcm5fZGIgPSBuOwoJCSB9Cgkg
fQogfQogCiBzdGF0aWMgdm9pZCBsb2FkX3NjdHBfc25tcCh2b2lkKQogewoJIEZJTEUgKmZwID0g
bmV0X3NjdHBfc25tcF9vcGVuKCk7CiAKCSBpZiAoZnApIHsKCQkgbG9hZF9nb29kX3RhYmxlKGZw
KTsKCQkgZmNsb3NlKGZwKTsKCSB9CiB9CiAKIHN0YXRpYyB2b2lkIGxvYWRfc25tcCh2b2lkKQog
ewoJIEZJTEUgKmZwID0gbmV0X3NubXBfb3BlbigpOwogCgkgaWYgKGZwKSB7CgkJIGxvYWRfdWds
eV90YWJsZShmcCk7CgkJIGZjbG9zZShmcCk7CgkgfQogfQogCiBzdGF0aWMgdm9pZCBsb2FkX3Nu
bXA2KHZvaWQpCiB7CgkgRklMRSAqZnAgPSBuZXRfc25tcDZfb3BlbigpOwogCgkgaWYgKGZwKSB7
CgkJIGxvYWRfZ29vZF90YWJsZShmcCk7CgkJIGZjbG9zZShmcCk7CgkgfQogfQogCiBzdGF0aWMg
dm9pZCBsb2FkX25ldHN0YXQodm9pZCkKIHsKCSBGSUxFICpmcCA9IG5ldF9uZXRzdGF0X29wZW4o
KTsKIAoJIGlmIChmcCkgewoJCSBsb2FkX3VnbHlfdGFibGUoZnApOwoJCSBmY2xvc2UoZnApOwoJ
IH0KIH0KIAogCiBzdGF0aWMgdm9pZCBkdW1wX2tlcm5fZGIoRklMRSAqZnAsIGludCB0b19oaXN0
KQogewoJIGpzb25fd3JpdGVyX3QgKmp3ID0ganNvbl9vdXRwdXQgPyBqc29ud19uZXcoZnApIDog
TlVMTDsKCSBzdHJ1Y3QgbnN0YXRfZW50ICpuLCAqaDsKIAoJIGggPSBoaXN0X2RiOwoJIGlmIChq
dykgewoJCSBqc29ud19zdGFydF9vYmplY3QoancpOwoJCSBqc29ud19wcmV0dHkoancsIHByZXR0
eSk7CgkJIGpzb253X25hbWUoancsIGluZm9fc291cmNlKTsKCQkganNvbndfc3RhcnRfb2JqZWN0
KGp3KTsKCSB9IGVsc2UKCQkgZnByaW50ZihmcCwgIiMlc1xuIiwgaW5mb19zb3VyY2UpOwogCgkg
Zm9yIChuID0ga2Vybl9kYjsgbjsgbiA9IG4tPm5leHQpIHsKCQkgdW5zaWduZWQgbG9uZyBsb25n
IHZhbCA9IG4tPnZhbDsKIAoJCSBpZiAoIWR1bXBfemVyb3MgJiYgIXZhbCAmJiAhbi0+cmF0ZSkK
CQkJIGNvbnRpbnVlOwoJCSBpZiAoIW1hdGNoKG4tPmlkKSkgewoJCQkgc3RydWN0IG5zdGF0X2Vu
dCAqaDE7CiAKCQkJIGlmICghdG9faGlzdCkKCQkJCSBjb250aW51ZTsKCQkJIGZvciAoaDEgPSBo
OyBoMTsgaDEgPSBoMS0+bmV4dCkgewoJCQkJIGlmIChzdHJjbXAoaDEtPmlkLCBuLT5pZCkgPT0g
MCkgewoJCQkJCSB2YWwgPSBoMS0+dmFsOwoJCQkJCSBoID0gaDEtPm5leHQ7CgkJCQkJIGJyZWFr
OwoJCQkJIH0KCQkJIH0KCQkgfQogCgkJIGlmIChqdykKCQkJIGpzb253X3VpbnRfZmllbGQoancs
IG4tPmlkLCB2YWwpOwoJCSBlbHNlCgkJCSBmcHJpbnRmKGZwLCAiJS0zMnMlLTE2bGx1JTYuMWZc
biIsIG4tPmlkLCB2YWwsIG4tPnJhdGUpOwoJIH0KIAoJIGlmIChqdykgewoJCSBqc29ud19lbmRf
b2JqZWN0KGp3KTsKIAoJCSBqc29ud19lbmRfb2JqZWN0KGp3KTsKCQkganNvbndfZGVzdHJveSgm
ancpOwoJIH0KIH0KIAogc3RhdGljIHZvaWQgZHVtcF9pbmNyX2RiKEZJTEUgKmZwKQogewoJIGpz
b25fd3JpdGVyX3QgKmp3ID0ganNvbl9vdXRwdXQgPyBqc29ud19uZXcoZnApIDogTlVMTDsKCSBz
dHJ1Y3QgbnN0YXRfZW50ICpuLCAqaDsKIAoJIGggPSBoaXN0X2RiOwoJIGlmIChqdykgewoJCSBq
c29ud19zdGFydF9vYmplY3QoancpOwoJCSBqc29ud19wcmV0dHkoancsIHByZXR0eSk7CgkJIGpz
b253X25hbWUoancsIGluZm9fc291cmNlKTsKCQkganNvbndfc3RhcnRfb2JqZWN0KGp3KTsKCSB9
IGVsc2UKCQkgZnByaW50ZihmcCwgIiMlc1xuIiwgaW5mb19zb3VyY2UpOwogCgkgZm9yIChuID0g
a2Vybl9kYjsgbjsgbiA9IG4tPm5leHQpIHsKCQkgaW50IG92ZmwgPSAwOwoJCSB1bnNpZ25lZCBs
b25nIGxvbmcgdmFsID0gbi0+dmFsOwoJCSBzdHJ1Y3QgbnN0YXRfZW50ICpoMTsKIAoJCSBmb3Ig
KGgxID0gaDsgaDE7IGgxID0gaDEtPm5leHQpIHsKCQkJIGlmIChzdHJjbXAoaDEtPmlkLCBuLT5p
ZCkgPT0gMCkgewoJCQkJIGlmICh2YWwgPCBoMS0+dmFsKSB7CgkJCQkJIG92ZmwgPSAxOwoJCQkJ
CSB2YWwgPSBoMS0+dmFsOwoJCQkJIH0KCQkJCSB2YWwgLT0gaDEtPnZhbDsKCQkJCSBoID0gaDEt
Pm5leHQ7CgkJCQkgYnJlYWs7CgkJCSB9CgkJIH0KCQkgaWYgKCFkdW1wX3plcm9zICYmICF2YWwg
JiYgIW4tPnJhdGUpCgkJCSBjb250aW51ZTsKCQkgaWYgKCFtYXRjaChuLT5pZCkpCgkJCSBjb250
aW51ZTsKIAoJCSBpZiAoancpCgkJCSBqc29ud191aW50X2ZpZWxkKGp3LCBuLT5pZCwgdmFsKTsK
CQkgZWxzZQoJCQkgZnByaW50ZihmcCwgIiUtMzJzJS0xNmxsdSU2LjFmJXNcbiIsIG4tPmlkLCB2
YWwsCgkJCQkgbi0+cmF0ZSwgb3ZmbD8iIChvdmVyZmxvdykiOiIiKTsKCSB9CiAKCSBpZiAoancp
IHsKCQkganNvbndfZW5kX29iamVjdChqdyk7CiAKCQkganNvbndfZW5kX29iamVjdChqdyk7CgkJ
IGpzb253X2Rlc3Ryb3koJmp3KTsKCSB9CiB9CiAKIHN0YXRpYyBpbnQgY2hpbGRyZW47CiAKIHN0
YXRpYyB2b2lkIHNpZ2NoaWxkKGludCBzaWdubykKIHsKIH0KIAogc3RhdGljIHZvaWQgdXBkYXRl
X2RiKGludCBpbnRlcnZhbCkKIHsKCSBzdHJ1Y3QgbnN0YXRfZW50ICpuLCAqaDsKIAoJIG4gPSBr
ZXJuX2RiOwoJIGtlcm5fZGIgPSBOVUxMOwogCgkgbG9hZF9uZXRzdGF0KCk7CgkgbG9hZF9zbm1w
NigpOwoJIGxvYWRfc25tcCgpOwoJIGxvYWRfc2N0cF9zbm1wKCk7CiAKCSBoID0ga2Vybl9kYjsK
CSBrZXJuX2RiID0gbjsKIAoJIGZvciAobiA9IGtlcm5fZGI7IG47IG4gPSBuLT5uZXh0KSB7CgkJ
IHN0cnVjdCBuc3RhdF9lbnQgKmgxOwogCgkJIGZvciAoaDEgPSBoOyBoMTsgaDEgPSBoMS0+bmV4
dCkgewoJCQkgaWYgKHN0cmNtcChoMS0+aWQsIG4tPmlkKSA9PSAwKSB7CgkJCQkgZG91YmxlIHNh
bXBsZTsKCQkJCSB1bnNpZ25lZCBsb25nIGxvbmcgaW5jciA9IGgxLT52YWwgLSBuLT52YWw7CiAK
CQkJCSBuLT52YWwgPSBoMS0+dmFsOwoJCQkJIHNhbXBsZSA9IChkb3VibGUpaW5jciAqIDEwMDAu
MCAvIGludGVydmFsOwoJCQkJIGlmIChpbnRlcnZhbCA+PSBzY2FuX2ludGVydmFsKSB7CgkJCQkJ
IG4tPnJhdGUgKz0gVyooc2FtcGxlLW4tPnJhdGUpOwoJCQkJIH0gZWxzZSBpZiAoaW50ZXJ2YWwg
Pj0gMTAwMCkgewoJCQkJCSBpZiAoaW50ZXJ2YWwgPj0gdGltZV9jb25zdGFudCkgewoJCQkJCQkg
bi0+cmF0ZSA9IHNhbXBsZTsKCQkJCQkgfSBlbHNlIHsKCQkJCQkJIGRvdWJsZSB3ID0gVyooZG91
YmxlKWludGVydmFsL3NjYW5faW50ZXJ2YWw7CiAKCQkJCQkJIG4tPnJhdGUgKz0gdyooc2FtcGxl
LW4tPnJhdGUpOwoJCQkJCSB9CgkJCQkgfQogCgkJCQkgd2hpbGUgKGggIT0gaDEpIHsKCQkJCQkg
c3RydWN0IG5zdGF0X2VudCAqdG1wID0gaDsKIAoJCQkJCSBoID0gaC0+bmV4dDsKCQkJCQkgZnJl
ZSh0bXAtPmlkKTsKCQkJCQkgZnJlZSh0bXApOwoJCQkJIH07CgkJCQkgaCA9IGgxLT5uZXh0OwoJ
CQkJIGZyZWUoaDEtPmlkKTsKCQkJCSBmcmVlKGgxKTsKCQkJCSBicmVhazsKCQkJIH0KCQkgfQoJ
IH0KIH0KIAogI2RlZmluZSBUX0RJRkYoYSwgYikgKCgoYSkudHZfc2VjLShiKS50dl9zZWMpKjEw
MDAgKyAoKGEpLnR2X3VzZWMtKGIpLnR2X3VzZWMpLzEwMDApCiAKIAogc3RhdGljIHZvaWQgc2Vy
dmVyX2xvb3AoaW50IGZkKQogewoJIHN0cnVjdCB0aW1ldmFsIHNuYXB0aW1lID0geyAwIH07Cgkg
c3RydWN0IHBvbGxmZCBwOwogCgkgcC5mZCA9IGZkOwoJIHAuZXZlbnRzID0gcC5yZXZlbnRzID0g
UE9MTElOOwogCgkgc25wcmludGYoaW5mb19zb3VyY2UsIHNpemVvZihpbmZvX3NvdXJjZSksICIl
ZC4lbHUgc2FtcGxpbmdfaW50ZXJ2YWw9JWQgdGltZV9jb25zdD0lZCIsCgkJIGdldHBpZCgpLCAo
dW5zaWduZWQgbG9uZylyYW5kb20oKSwgc2Nhbl9pbnRlcnZhbC8xMDAwLCB0aW1lX2NvbnN0YW50
LzEwMDApOwogCgkgbG9hZF9uZXRzdGF0KCk7CgkgbG9hZF9zbm1wNigpOwoJIGxvYWRfc25tcCgp
OwoJIGxvYWRfc2N0cF9zbm1wKCk7CiAKCSBmb3IgKDs7KSB7CgkJIGludCBzdGF0dXM7CgkJIHRp
bWVfdCB0ZGlmZjsKCQkgc3RydWN0IHRpbWV2YWwgbm93OwogCgkJIGdldHRpbWVvZmRheSgmbm93
LCBOVUxMKTsKCQkgdGRpZmYgPSBUX0RJRkYobm93LCBzbmFwdGltZSk7CgkJIGlmICh0ZGlmZiA+
PSBzY2FuX2ludGVydmFsKSB7CgkJCSB1cGRhdGVfZGIodGRpZmYpOwoJCQkgc25hcHRpbWUgPSBu
b3c7CgkJCSB0ZGlmZiA9IDA7CgkJIH0KCQkgaWYgKHBvbGwoJnAsIDEsIHNjYW5faW50ZXJ2YWwg
LSB0ZGlmZikgPiAwCgkJCSAmJiAocC5yZXZlbnRzJlBPTExJTikpIHsKCQkJIGludCBjbG50ID0g
YWNjZXB0KGZkLCBOVUxMLCBOVUxMKTsKIAoJCQkgaWYgKGNsbnQgPj0gMCkgewoJCQkJIHBpZF90
IHBpZDsKIAoJCQkJIGlmIChjaGlsZHJlbiA+PSA1KSB7CgkJCQkJIGNsb3NlKGNsbnQpOwoJCQkJ
IH0gZWxzZSBpZiAoKHBpZCA9IGZvcmsoKSkgIT0gMCkgewoJCQkJCSBpZiAocGlkID4gMCkKCQkJ
CQkJIGNoaWxkcmVuKys7CgkJCQkJIGNsb3NlKGNsbnQpOwoJCQkJIH0gZWxzZSB7CgkJCQkJIEZJ
TEUgKmZwID0gZmRvcGVuKGNsbnQsICJ3Iik7CiAKCQkJCQkgaWYgKGZwKQoJCQkJCQkgZHVtcF9r
ZXJuX2RiKGZwLCAwKTsKCQkJCQkgZXhpdCgwKTsKCQkJCSB9CgkJCSB9CgkJIH0KCQkgd2hpbGUg
KGNoaWxkcmVuICYmIHdhaXRwaWQoLTEsICZzdGF0dXMsIFdOT0hBTkcpID4gMCkKCQkJIGNoaWxk
cmVuLS07CgkgfQogfQogCiBzdGF0aWMgaW50IHZlcmlmeV9mb3JnaW5nKGludCBmZCkKIHsKCSBz
dHJ1Y3QgdWNyZWQgY3JlZDsKCSBzb2NrbGVuX3Qgb2xlbiA9IHNpemVvZihjcmVkKTsKIAoJIGlm
IChnZXRzb2Nrb3B0KGZkLCBTT0xfU09DS0VULCBTT19QRUVSQ1JFRCwgKHZvaWQgKikmY3JlZCwg
Jm9sZW4pIHx8CgkJIG9sZW4gPCBzaXplb2YoY3JlZCkpCgkJIHJldHVybiAtMTsKCSBpZiAoY3Jl
ZC51aWQgPT0gZ2V0dWlkKCkgfHwgY3JlZC51aWQgPT0gMCkKCQkgcmV0dXJuIDA7CgkgcmV0dXJu
IC0xOwogfQogCiBzdGF0aWMgdm9pZCB1c2FnZSh2b2lkKSBfX2F0dHJpYnV0ZV9fKChub3JldHVy
bikpOwogCiBzdGF0aWMgdm9pZCB1c2FnZSh2b2lkKQogewoJIGZwcmludGYoc3RkZXJyLAoJCSAi
VXNhZ2U6IG5zdGF0IFtPUFRJT05dIFsgUEFUVEVSTiBbIFBBVFRFUk4gXSBdXG4iCgkJICIgICAt
aCwgLS1oZWxwICAgICAgICAgIHRoaXMgbWVzc2FnZVxuIgoJCSAiICAgLWEsIC0taWdub3JlICAg
ICAgICBpZ25vcmUgaGlzdG9yeVxuIgoJCSAiICAgLWQsIC0tc2Nhbj1TRUNTICAgICBzYW1wbGUg
ZXZlcnkgc3RhdGlzdGljcyBldmVyeSBTRUNTXG4iCgkJICIgICAtaiwgLS1qc29uICAgICAgICAg
IGZvcm1hdCBvdXRwdXQgaW4gSlNPTlxuIgoJCSAiICAgLW4sIC0tbm9vdXRwdXQgICAgICBkbyBo
aXN0b3J5IG9ubHlcbiIKCQkgIiAgIC1wLCAtLXByZXR0eSAgICAgICAgcHJldHR5IHByaW50XG4i
CgkJICIgICAtciwgLS1yZXNldCAgICAgICAgIHJlc2V0IGhpc3RvcnlcbiIKCQkgIiAgIC1zLCAt
LW5vdXBkYXRlICAgICAgZG9uJ3QgdXBkYXRlIGhpc3RvcnlcbiIKCQkgIiAgIC10LCAtLWludGVy
dmFsPVNFQ1MgcmVwb3J0IGF2ZXJhZ2Ugb3ZlciB0aGUgbGFzdCBTRUNTXG4iCgkJICIgICAtViwg
LS12ZXJzaW9uICAgICAgIG91dHB1dCB2ZXJzaW9uIGluZm9ybWF0aW9uXG4iCgkJICIgICAteiwg
LS16ZXJvcyAgICAgICAgIHNob3cgZW50cmllcyB3aXRoIHplcm8gYWN0aXZpdHlcbiIpOwoJIGV4
aXQoLTEpOwogfQogCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9wdGlvbiBsb25nb3B0c1tdID0gewoJ
IHsgImhlbHAiLCAwLCAwLCAnaCcgfSwKCSB7ICJpZ25vcmUiLCAgMCwgIDAsICdhJyB9LAoJIHsg
InNjYW4iLCAxLCAwLCAnZCd9LAoJIHsgIm5vb3V0cHV0IiwgMCwgMCwgJ24nIH0sCgkgeyAianNv
biIsIDAsIDAsICdqJyB9LAoJIHsgInJlc2V0IiwgMCwgMCwgJ3InIH0sCgkgeyAibm91cGRhdGUi
LCAwLCAwLCAncycgfSwKCSB7ICJwcmV0dHkiLCAwLCAwLCAncCcgfSwKCSB7ICJpbnRlcnZhbCIs
IDEsIDAsICd0JyB9LAoJIHsgInZlcnNpb24iLCAwLCAwLCAnVicgfSwKCSB7ICJ6ZXJvcyIsIDAs
IDAsICd6JyB9LAoJIHsgMCB9CiB9OwogCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltd
KSB7CiAgICBpZiAoYXJnYyAhPSAyKSB7CiAgICAgICAgZnByaW50ZihzdGRlcnIsICJVc2FnZTog
JXMgPGlucHV0X2ZpbGU+XG4iLCBhcmd2WzBdKTsKICAgICAgICByZXR1cm4gLTE7CiAgICB9CiAg
ICBGSUxFICpmcCA9IGZvcGVuKGFyZ3ZbMV0sICJyIik7CiAgICBpZiAoIWZwKSB7CiAgICAgICAg
cGVycm9yKCJmb3BlbiIpOwogICAgICAgIHJldHVybiAtMTsKICAgIH0KICAgIGxvYWRfdWdseV90
YWJsZShmcCk7CiAgICBmY2xvc2UoZnApOwogICAgcmV0dXJuIDA7Cn0K
--00000000000099dcf2062e7b26bf--

