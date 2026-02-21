Return-Path: <netdev+bounces-259816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B81AS1EmWmESQMAu9opvQ
	(envelope-from <netdev+bounces-259816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 06:35:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1E216C2E6
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 06:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 548CA3030B36
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 05:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052D286410;
	Sat, 21 Feb 2026 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="UJDTErJo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4D4414
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 05:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771652137; cv=none; b=tVID11aGnVY4ndNQGmtDp+XFGI01d8E/ZI4u82zkvGUN711CtenAj92Yj65Xrg3b5MXoD3/PMCSbdw8Agh2v1NFflOwuoDoC9oj5q5eDClIxvtsUJSc1CrqHaoCq6bTBpM9VushXAItkgkJoSqe6yoMTwMvch8unagtLhcGzfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771652137; c=relaxed/simple;
	bh=5qH1LrLrLDiVb2kaKGK5Vwbm30x4/G5Xg+w/R9Za6Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/3MkH+0GpjejhK6NCxH0UXnR4ys9/k2cQovpCHpL4iG4Y0xU588sDG0hPKuT4zyAUIyMVtVdn8ApvP2dvSgQdq6BCeo/lG2neww0XElETK1cK37mQL7Mu5LooGD4VB549UuTXn16JIuMklZb7aHcbPhk8URqB+ui34qnBsruoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=UJDTErJo; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6f21c2d81so264600285a.2
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771652135; x=1772256935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kf50zJ95esjyGsfgOuMwdxzW3Z/K3g4Iqb5Y6hn44Q=;
        b=UJDTErJodgwMQucW6UZGuGxQiWfui8yuitrZowy36AgRjvO47AQPjx7KOxBtUpHyRS
         gPPsDXxGTyxhXWgWa7qGyjvLdvr7ibF/AtASShMkh9Mpp1bUq1VyKmPIVOIfTeuq1ker
         Ku41O5CMnrdEvT/9SO6pM5ijgDhGPq/2hJEmAoDkjaDu/ved3eRluEzxlxYxErPGHM7W
         XULkUqjIPjugpdXZNDv9gUfxEtLD5lVRnX2TdzAaTLe1ws2CAkVmQ/q9gEbdg9IRlpHh
         kAAcedw46FFMENdVeBxJKL8Mnnxco54+ahotAAciFECGpN/OF0kGJcK9pLoDnuKygvfo
         aaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771652135; x=1772256935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2kf50zJ95esjyGsfgOuMwdxzW3Z/K3g4Iqb5Y6hn44Q=;
        b=wCuTg5ZVCubdcQCInFKG1R9ii7zrlfBukPditseRgpUvDAYE/PKjSyO3bzPsVrmAN6
         706mRaQh0uGEEBJmQKHKPM9ZyXla/soYrBmCbTIa29uoOOh9sCLxc9GlmXhxiAKtlAE+
         CmrlFcy1PfSrPKLBlyC83qaZCdboC49TGDHzol4wWhKklfwK+UBhf4MVMKB8maVImN47
         RCkHWsxtrHbiuBqmmTJwguaMNCTgt86AJCzSXFESUa3DUR/BuR3kum/89V/d9DWK/g3w
         VdeF9djysi7RNmYOeaLSc6UNvlNTmM6ZPKVM8LLgxMNbdh2mUq5lfxuUuzzwauLZwJvh
         o8jw==
X-Forwarded-Encrypted: i=1; AJvYcCUuYC5mGdE685w12+IZpLu3BcSQj5XbVjU/lWUHPocqlaQEviLvkqwmkgveMQikDOYBNYGSDvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivTvPN79KYa+obxUTNjWF4UP8Pbyth2/wPX/m6bv+drwTosm4
	RKabB7cldE6d0hjtuJUCTi194oqde6jsT2LkgWiOTSDbxz7bLuJNJ4vTPf4ZrVK9Dom3DtHzBLy
	8FXnp
X-Gm-Gg: AZuq6aLSJ22IuONFIPhyIhOG9CRx/6SYusamTLNYkRBN+5GG4IOHnVb9yzytJi6iHio
	Xd+c/qy/fayuBOstXGvH0tDvpej7i/iGQu5dNs7yJ7A5VUw3ITQxdiVC+Pdjq+6W53g0bTUTKbh
	oVeLO5HGCvh4wfWga4U+uOv5fb3WFGQW3oZoUNm6Wf0Z8wWHpK2OWH/nr5H1gd58WeRUI1kZOtZ
	Gz1wEzAFjHiRI/2WVvlJ/rEmkFB8HKjQnDbJ8fSJyLikA7griBPjjKUnAc16b06H6JIQz9cc0jq
	p0Zh8sMZQVkEshbgNRPvZPIE5cUqkH/FKKDUDhfkGfyVqqD4cNQ6SbXHsCQi4heqoIvyB6OuTP9
	HnImf5F+wiPFLTASzdg7fRYhNsZ7YVN1Cle9mTVOQlhQDH+xbQXyha0/dxP3JM4rVb3/jZofPqL
	cAnwu7wGSig/ATLxxg9Ot3LdLz57b/Vd3PcIN7DokYfTCQQAcUY2u/d7/fppotKLtd
X-Received: by 2002:a05:620a:170f:b0:8ca:363a:cd73 with SMTP id af79cd13be357-8cb8ca834d2mr252625985a.68.1771652134876;
        Fri, 20 Feb 2026 21:35:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e6341c4sm10841026d6.35.2026.02.20.21.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 21:35:34 -0800 (PST)
Date: Fri, 20 Feb 2026 21:35:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next 0/3] ip mptcp monitor: add JSON support
Message-ID: <20260220213531.2d930e5d@phoenix.local>
In-Reply-To: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
References: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259816-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[phoenix.local:mid,networkplumber-org.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D1E216C2E6
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 19:54:00 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> With this series, the command 'ip [-t[s]] mptcp monitor' produces an
> output with the JSON format.
>=20
> - Patch 1: a small refactoring to uniform the code.
>=20
> - Patch 2: add JSON support in print_timestamp() helper.
>=20
> - Patch 3: add JSON support to 'ip mptcp monitor' as requested by
>   Stephen.
>=20
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (3):
>       mptcp: uniform stream closure
>       utils: timestamp: add JSON support
>       mptcp: monitor: add JSON support
>=20
>  ip/ipmptcp.c | 96 +++++++++++++++++++++++++++++++++++++++++-------------=
------
>  lib/utils.c  | 19 ++++++++----
>  2 files changed, 80 insertions(+), 35 deletions(-)
> ---
> base-commit: f120cdb35da76ca99932d0428a0917bd01a843da
> change-id: 20260220-ipr-monitor-json-1573371524c1
>=20
> Best regards,

I used recent review-prompt to do a more deep dive AI analysis.
And it found:

Here's the deep dive review. The series is solid work from Matthieu =E2=80=
=94
clean, well-structured, and follows iproute2 conventions. The main
items worth raising:

token printed via print_uint() with %08x format =E2=80=94 text will show hex
but JSON will emit decimal. Probably fine (JSON consumers prefer raw
numbers), but worth a conscious decision.

Signal handler calls delete_json_obj() and rtnl_close() =E2=80=94 these are=
n't
async-signal-safe. Pragmatically OK for a Ctrl-C'd monitor tool, but
rtnl_close() could be dropped since exit() cleans up the socket anyway.

Missing delete_json_obj() on the normal/error exit path after
rtnl_listen() returns =E2=80=94 if it fails rather than being signaled, the
JSON ] never gets written.

Patch 1 quietly fixes a real bug (fflush before close_json_object) =E2=80=94
the commit message could call that out more explicitly.

--------
# Review: [PATCH iproute2-next 0/3] ip mptcp monitor: add JSON support

**Author**: Matthieu Baerts (NGI0) \<matttbe@kernel.org\>
**Date**: Fri, 20 Feb 2026
**Series**: 3 patches

## Overview

This series adds JSON output support to `ip mptcp monitor`, converting raw =
`printf()` calls to the standard `print_XXX()` helpers. It's well-structure=
d as three incremental patches: a cleanup, a utility enhancement, and the m=
ain feature. Overall this is solid work =E2=80=94 the conversion is thoroug=
h and follows iproute2 conventions well. I have a few comments below, mostl=
y minor.

---

## Patch 1/3: mptcp: uniform stream closure

**Verdict: Looks good.**

This is a clean refactoring. Two changes:

1. Replaces `print_string(PRINT_FP, NULL, "\n", NULL)` and `print_string(PR=
INT_FP, NULL, "%s", "\n")` with `print_nl()` =E2=80=94 correct and cleaner.

2. Reorders `close_json_object()` to come *after* `print_nl()` but *before*=
 `fflush()`. This is the right ordering: newline belongs inside the object'=
s text representation, and flushing should happen after the JSON object is =
fully closed so the complete JSON is written out.

In `print_mptcp_limit()`, the original code called `fflush(stdout)` before =
`close_json_object()` =E2=80=94 that's a bug in the existing code (would fl=
ush incomplete JSON). This patch fixes it. Worth noting in the commit messa=
ge that this is a bugfix, not just cosmetic.

No issues.

---

## Patch 2/3: utils: timestamp: add JSON support

**Verdict: Acceptable, with comments.**

Adds JSON-aware output to `print_timestamp()` by using `print_string()` whe=
n `fp =3D=3D stdout`, falling back to `fprintf()` otherwise.

### Comments

**1. The `fp =3D=3D stdout` conditional pattern is unusual but justified he=
re.**

The commit message explains this: the `print_XXX()` helpers only write to s=
tdout, so when `fp` is something else (e.g. stderr), it must fall back to `=
fprintf()`. This is a reasonable pragmatic choice given the existing API. A=
 brief inline comment in the code would help future readers understand *why=
* the check exists:

```c
/* print_string() only outputs to stdout; fall back to fprintf() for other =
streams */
if (fp =3D=3D stdout)
```

**2. JSON key naming: `timestamp_short` vs `timestamp`.**

The short timestamp gets key `"timestamp_short"` while the long one gets `"=
timestamp"`. This means JSON consumers need to know which format was reques=
ted to know which key to look for. Consider using a single key name (e.g. `=
"timestamp"`) for both, since only one can ever be present at a time and co=
nsumers shouldn't need to care about the format variant. Up to the maintain=
er though =E2=80=94 there may be value in distinguishing them.

**3. The `snprintf` composition is clean.**

Building the timestamp string first with `strftime` + `snprintf` for the mi=
croseconds, then passing the complete string to `print_string()`, is the ri=
ght approach. It avoids needing two separate JSON fields for the time and m=
icrosecond components.

**4. Minor: `strftime()` return value.**

`strftime()` returns 0 on failure (buffer too small). The code uses the ret=
urn value in `ts + len` without checking for 0. The buffer is 40 bytes and =
the format `"%Y-%m-%dT%H:%M:%S"` is ~19 chars, so this is safe in practice,=
 but a pedantic reviewer might want a check. Not a blocker.

---

## Patch 3/3: mptcp: monitor: add JSON support

**Verdict: Good overall, a few points to discuss.**

This is the main patch. It converts all `printf()` / `color_fprintf()` call=
s in `mptcp_monitor_msg()` to `print_XXX()` helpers and adds JSON object fr=
aming and signal handling.

### What's done well

- Consistent use of `print_uint(PRINT_ANY, ...)`, `print_string(PRINT_ANY, =
...)`, `print_0xhex(PRINT_ANY, ...)` throughout =E2=80=94 no fprintf-to-std=
out for display output.
- Error output isn't affected (no stdout corruption risk).
- `open_json_object(NULL)` / `close_json_object()` properly paired in `mptc=
p_monitor_msg()`.
- The boolean flags (`server_side`, `deny_join_id0`) correctly use separate=
 `print_string(PRINT_FP, ...)` / `print_bool(PRINT_JSON, ...)` paths =E2=80=
=94 this is one of the legitimate cases for separate JSON/text output, sinc=
e the text format is a bare keyword while JSON needs a proper boolean value.
- Merging the two identical `UNKNOWN` cases into one `||` condition is a ni=
ce cleanup.

### Comments

**1. `token` format: `%08x` in `print_uint()` =E2=80=94 JSON will emit deci=
mal, not hex.**

```c
print_uint(PRINT_ANY, "token"," token=3D%08x",
           rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));
```

The text format string `%08x` will show hex in text mode, but `print_uint()=
` emits the raw numeric value in JSON mode =E2=80=94 which will be decimal.=
 This changes the JSON representation from what a user might expect for a t=
oken (usually seen as hex). Two options:

- Use `print_0xhex()` if you want hex in both modes.
- Accept decimal in JSON (it's a valid uint32) and document it. JSON consum=
ers typically prefer raw numeric values anyway.

Either way, this deserves a conscious decision. The same applies to `reset_=
flags` but that one already uses `print_0xhex()` which is correct.

**2. Missing space before `"token"` format string.**

```c
print_uint(PRINT_ANY, "token"," token=3D%08x",
```

There's a missing space after `"token",` =E2=80=94 purely cosmetic, but the=
 rest of the file has consistent spacing after commas. Very minor.

**3. Signal handler safety: `sig_exit_json()` calls non-async-signal-safe f=
unctions.**

```c
static void sig_exit_json(int signo)
{
    delete_json_obj();
    rtnl_close(&genl_rth);
    exit(0);
}
```

`delete_json_obj()` ultimately calls `fwrite()`/`fflush()` to emit the clos=
ing `]`, and `rtnl_close()` calls `close()`. Strictly speaking, `fwrite`/`f=
flush` are not async-signal-safe (POSIX). If the signal arrives while insid=
e `printf()` or another stdio call in `mptcp_monitor_msg()`, this could dea=
dlock or corrupt the stream.

In practice, for a simple monitoring tool that's being Ctrl-C'd by a user, =
this is unlikely to cause real problems. But the technically correct approa=
ch would be to set a volatile flag in the signal handler and check it in th=
e main loop, or use `sigaction` with `SA_RESTART` and handle cleanup after =
`rtnl_listen()` returns.

This pattern does exist in other iproute2 monitor commands, so it may be ac=
ceptable as-is. Worth noting for awareness.

**4. `rtnl_close(&genl_rth)` in signal handler =E2=80=94 is this necessary?=
**

Other monitor commands (e.g. `ip monitor`) don't close the rtnl handle in s=
ignal handlers. The process is about to `exit(0)` anyway, so the kernel wil=
l clean up the socket. Removing it would reduce the signal-safety concern.

**5. `new_json_obj(json)` placement.**

```c
new_json_obj(json);

if (is_json_context()) {
    struct sigaction sa =3D { .sa_handler =3D sig_exit_json };

    sigaction(SIGINT, &sa, NULL);
    sigaction(SIGTERM, &sa, NULL);
}
```

This looks correct =E2=80=94 `new_json_obj()` initializes the JSON context,=
 and then the signal handlers are only installed when actually in JSON mode=
. Good.

However, there's no corresponding `delete_json_obj()` on the normal exit pa=
th (after `rtnl_listen()` returns). If `rtnl_listen()` returns due to an er=
ror rather than a signal, the JSON output won't be properly closed. Conside=
r adding cleanup after the `rtnl_listen()` call:

```c
if (rtnl_listen(&genl_rth, mptcp_monitor_msg, stdout) < 0) {
    delete_json_obj();
    return 2;
}

delete_json_obj();
return 0;
```

**6. `sigaction` struct initialization.**

```c
struct sigaction sa =3D { .sa_handler =3D sig_exit_json };
```

This zero-initializes the rest of the struct via designated initializer, so=
 `sa_mask` is empty and `sa_flags` is 0. That's fine. The `SA_RESTART` flag=
 is intentionally not set, which means `rtnl_listen()` will be interrupted =
by the signal and return `EINTR` =E2=80=94 but the signal handler calls `ex=
it(0)` so it never actually returns. Acceptable.

---

## Commit Message Quality

All three patches have proper `Signed-off-by`, correct `[PATCH iproute2-nex=
t]` prefix, and reasonable descriptions. Patch 2's message is the most deta=
iled, which is appropriate since it has the most subtle design decision (th=
e `fp =3D=3D stdout` check).

One suggestion: Patch 1's message could mention that the reordering of `clo=
se_json_object()` vs `fflush()` in `print_mptcp_limit()` fixes incorrect fl=
ush ordering, not just "uniform" the code.

---

## Summary

| Check | Status |
|---|---|
| `strcmp()` not `matches()` | N/A (no arg parsing changes) |
| `print_XXX()` helpers used | =E2=9C=85 All printf=E2=86=92print_XXX conve=
rsions correct |
| Errors to stderr | =E2=9C=85 No error output changes |
| JSON open/close paired | =E2=9C=85 Balanced in mptcp_monitor_msg |
| `PRINT_ANY` preferred | =E2=9C=85 Used throughout; separate paths only wh=
ere justified |
| Signed-off-by present | =E2=9C=85 All three patches |
| Subject format | =E2=9C=85 `[PATCH iproute2-next N/3]` |
| No string breaking | =E2=9C=85 |
| Coding style | =E2=9C=85 Tabs, braces, naming all correct |

**Key items for author attention:**

1. **`token` hex format** =E2=80=94 confirm whether decimal in JSON is inte=
ntional (probably fine, but worth a note)
2. **Signal handler safety** =E2=80=94 pragmatically OK, but consider remov=
ing `rtnl_close()` from the handler
3. **Missing `delete_json_obj()`** on `rtnl_listen()` error path
4. Consider single `"timestamp"` key name in patch 2


